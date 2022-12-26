FROM ruby:3.1.2

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE 1

RUN gem install "bundler:~>2" --no-document && \
    gem update --system && \
    gem cleanup

ARG NODE_VERSION=16.13.0
ARG YARN_VERSION=3.2.2

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

COPY package.json .
COPY yarn.lock .
COPY .yarnrc.docker.yml .yarnrc.yml
COPY .yarn/releases .yarn/releases
RUN corepack enable

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends imagemagick libvips libvips-dev libvips-tools libpq-dev poppler-utils && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt

WORKDIR /app
COPY ./Gemfile* /app/
RUN bundle config --local without "development test omit" && bundle install --jobs $(nproc) --retry 5
COPY package.json yarn.lock /app/
RUN yarn install && yarn --version
COPY . /app

RUN bin/rails assets:precompile

CMD ["bin/rails", "s", "-b", "0.0.0.0"]

EXPOSE 3000
