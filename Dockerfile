## BUILDING
##   (from project root directory)
##   $ docker build -t ruby-for-kingfeast-ringtheking .
##
## RUNNING
##   $ docker run -p 3000:3000 ruby-for-kingfeast-ringtheking
##
## CONNECTING
##   Lookup the IP of your active docker host using:
##     $ docker-machine ip $(docker-machine active)
##   Connect to the container at DOCKER_IP:3000
##     replacing DOCKER_IP for the IP of your active docker host

FROM gcr.io/bitnami-containers/minideb-extras:jessie-r14-buildpack

MAINTAINER Bitnami <containers@bitnami.com>

ENV STACKSMITH_STACK_ID="8qqfhzm" \
    STACKSMITH_STACK_NAME="Ruby for kingfeast/ringtheking" \
    STACKSMITH_STACK_PRIVATE="1"

# Install required system packages
RUN install_packages libc6 libssl1.0.0 zlib1g libreadline6 libncurses5 libtinfo5 libffi6 libxml2-dev zlib1g-dev libxslt1-dev libgmp-dev ghostscript imagemagick libmysqlclient18 libpq5

RUN bitnami-pkg install ruby-2.4.1-0 --checksum eaf2341624588774f61e4aac4f53c437e98b1e97f6915ba6327d3ecdc6c2c3a2

ENV PATH=/opt/bitnami/ruby/bin:$PATH

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

# Ruby on Rails template
ENV RAILS_ENV=development

COPY Gemfile* /app/
WORKDIR /app

RUN bundle install --without production

COPY . /app

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
