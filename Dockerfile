FROM ruby:3.2.2-alpine

RUN apk add --update build-base bash bash-completion libffi-dev tzdata postgresql-client postgresql-dev nodejs npm yarn

WORKDIR /app

COPY Gemfile* /app/

RUN gem install bundler

RUN bundle install

RUN bundle binstubs --all

RUN touch $HOME/.bashrc

CMD [ "/bin/bash" ]