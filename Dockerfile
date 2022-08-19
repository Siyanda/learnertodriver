# syntax = docker/dockerfile:experimental

FROM ruby:3.1.2 as base

ARG NODE_VERSION=16.13.0
ARG YARN_VERSION=3.2.2
ARG BUNDLER_VERSION=2.3.20

ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

ENV PATH $PATH:/usr/local/bin

ARG BUNDLE_WITHOUT=development:test
ARG BUNDLE_PATH=vendor/bundle
ENV BUNDLE_PATH ${BUNDLE_PATH}
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

SHELL ["/bin/bash", "-c"]

RUN mkdir /app
WORKDIR /app
RUN mkdir -p tmp/pids

# We need NodeJS & Yarn for precompiling assets.
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

# Install JS dependencies using Yarn.
COPY package.json .
COPY yarn.lock .
COPY .yarnrc.docker.yml .yarnrc.yml
COPY .yarn/releases .yarn/releases
RUN corepack enable

RUN yarn install

FROM base as build

ENV DEV_PACKAGES git build-essential libpq-dev wget vim curl gzip xz-utils libsqlite3-dev

RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y ${DEV_PACKAGES} \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY . .

ENV SECRET_KEY_BASE 1

FROM base

ENV PACKAGES postgresql-client file vim curl gzip

RUN --mount=type=cache,id=prod-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=prod-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    ${PACKAGES} \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /app /app

RUN gem install -N bundler -v ${BUNDLER_VERSION}

COPY Gemfile* ./
RUN bundle install && rm -rf vendor/bundle/ruby/*/cache

RUN bundle exec rails assets:precompile

ENV PORT 3000

CMD ["bin/rails", "s", "-b", "0.0.0.0"]

EXPOSE 3000
