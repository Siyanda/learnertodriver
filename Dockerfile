# syntax=docker/dockerfile:1

FROM ruby:3.1.2 as builder

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE 1

RUN gem install "bundler:~>2" --no-document && gem update --system &&gem cleanup

RUN curl https://deb.nodesource.com/setup_19.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

WORKDIR /app
COPY ./Gemfile* /app/
RUN bundle config --local without "development test omit" && bundle install --jobs $(nproc) --retry 5
RUN bundle exec rails assets:precompile

COPY . /app
CMD ["bin/rails", "s", "-b", "0.0.0.0"]

EXPOSE 3000
