# Use the barebones version of Ruby 2.2.3.
FROM ruby:2.6.3-slim

# Optionally set a maintainer name to let people know who made this image.
MAINTAINER Siddhesh Pisal <pisalsiddhesh@gmail.com>

# Install dependencies:
#   - build-essential: To ensure certain gems can be compiled
#   - nodejs: Compile assets
#   - libmysqlclient-dev: Communicate with mysql through the mysql gem
#   - mysql-client: In case you want to talk directly to mysql

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev default-mysql-client apt-utils default-libmysqlclient-dev

# Set an environment variable to store where the app is installed to inside of the Docker image.
ENV INSTALL_PATH /app_docker
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile
RUN bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java


# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

# Expose a volume so that nginx will be able to read in assets in production.
VOLUME ["$INSTALL_PATH/public"]
# RUN bundle exec rake db:create db:migrate 
# The default command that gets ran will be to start the Unicorn server.
# CMD rails s
RUN bundle install 
RUN bundle update
