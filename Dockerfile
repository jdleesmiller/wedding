FROM ruby:2.5.0

RUN apt-get update -qq &&\
 apt-get install -y build-essential libpq-dev nodejs &&\
 useradd --user-group --create-home --shell /bin/false app

ENV HOME=/home/app
USER app

COPY --chown=app:app Gemfile Gemfile.lock $HOME/wedding/
WORKDIR $HOME/wedding
RUN bundle

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

COPY --chown=app:app . $HOME/wedding/
