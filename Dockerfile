FROM ubuntu:18.04
MAINTAINER Rob Haswell <me@robhaswell.co.uk>

RUN apt-get -qqy update
RUN apt-get -qqy upgrade
RUN apt-get -qqy install apache2-utils squid

COPY ./squid.conf /etc/squid/squid.conf

RUN mkdir /usr/etc

EXPOSE 3128
VOLUME /var/log/squid

ADD init /init
CMD ["/init"]
