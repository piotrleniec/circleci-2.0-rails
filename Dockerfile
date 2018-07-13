FROM circleci/ruby:2.5.1-node

RUN sudo mkdir app
RUN sudo chown circleci:circleci app
WORKDIR app

RUN gem install bundler
COPY --chown=circleci Gemfile Gemfile
COPY --chown=circleci Gemfile.lock Gemfile.lock
RUN bundle install --deployment

COPY --chown=circleci package.json package.json
COPY --chown=circleci yarn.lock yarn.lock
RUN yarn

COPY --chown=circleci . .

RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s"]
