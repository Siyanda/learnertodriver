FROM ruby:3.1.2

ENV RAILS_ENV=production
ENV SECRET_KEY_BASE 1

RUN gem install "bundler:~>2" --no-document && \
    gem update --system && \
    gem cleanup

RUN curl -fsSL https://bun.sh/install | bash

WORKDIR /app
COPY ./Gemfile* /app/
RUN bundle config --local without "development test omit" && bundle install --jobs $(nproc) --retry 5
COPY package.json bun.lockb /app/
RUN bun install && bun --version
COPY . /app

RUN bin/rails assets:precompile

CMD ["bin/rails", "s", "-b", "0.0.0.0"]

EXPOSE 3000
