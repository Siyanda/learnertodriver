# syntax=docker/dockerfile:1

FROM ruby:3.2.2
ENV SECRET_KEY_BASE 1

RUN gem install "bundler:~>2" --no-document && gem update --system && gem cleanup

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
                    imagemagick libvips libvips-dev libvips-tools libpq-dev poppler-utils && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt

WORKDIR /app
COPY ./Gemfile* /app/
RUN bundle config --local without "development test omit" && bundle install --jobs $(nproc) --retry 5

RUN bundle exec rails assets:precompile

COPY . /app
CMD ["bin/rails", "s", "-b", "0.0.0.0"]

EXPOSE 3000
