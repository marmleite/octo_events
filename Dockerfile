FROM ruby:2.7.2

ENV BUNDLER_VERSION=2.1.4

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client && apt-get install libpq-dev -y

WORKDIR /myapp

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle install

COPY . /
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000