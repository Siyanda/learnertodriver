# syntax = docker/dockerfile:experimental

ARG RUBY_VERSION=3.1.2
FROM ruby:${RUBY_VERSION} as base

LABEL fly_launch_runtime="rails"

ARG BUNDLER_VERSION=2.3.22

ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV}
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

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

COPY package.json .
COPY yarn.lock .
COPY .yarnrc.docker.yml .yarnrc.yml
COPY .yarn/releases .yarn/releases
RUN corepack enable

RUN yarn install

FROM base as build

RUN gem install -N bundler -v ${BUNDLER_VERSION}

COPY Gemfile* ./
RUN bundle install

COPY . .


FROM base

COPY --from=build /app /app
