# DOCKER_IMAGE_VERSION 20.12-229-g01bda5e
FROM ubuntu:18.04

ARG BRANCH=master

RUN apt-get update && apt-get -y install wget gnupg
RUN echo "deb http://apt.flussonic.com/repo/ ${BRANCH}/" > /etc/apt/sources.list.d/flussonic.list
RUN wget -q -O - http://apt.flussonic.com/binary/gpg.key | apt-key add -

RUN apt update && apt -y install flussonic-erlang=22.3.7
RUN apt -y install flussonic-transcoder-base=20.05
RUN apt -y install flussonic=20.12-229-g01bda5e

VOLUME ["/var/log/flussonic"]
VOLUME ["/var/run/flussonic"]
VOLUME ["/etc/flussonic"]

EXPOSE 80 443 1935 554

WORKDIR /opt/flussonic
CMD ["/opt/flussonic/bin/run", \
  "--debug", \
  "-p", "/var/run/flussonic/pid", \
  "-l", "/var/log/flussonic", \
  "-noinput"]
