FROM ruby:3.0.1

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

# Rails API dependencies
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  apt-utils \
  libssl-dev \
  nodejs \
  mariadb-server \
  ruby-railties \
  yarn \
  git-core \
  curl \
  build-essential \
  cmake

ENV APP_HOME /myapp
ENV PATH /myapp/node_modules/.bin:$PATH

WORKDIR $APP_HOME

RUN gem install bundler

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

COPY package.json $APP_HOME/package.json
COPY package-lock.json $APP_HOME/package-lock.json

RUN bundle install
RUN npm install
RUN yarn install

# ADD . $APP_HOME
# RUN cp $APP_HOME/config/database.example.yml $APP_HOME/config/database.yml

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
