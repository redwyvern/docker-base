FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

COPY sources.list /etc/apt

# apt-utils seems missing and warnings are shown, so we install it.
RUN apt-get update -q -q && \
 apt-get install --yes --force-yes \
     apt-utils \
     wget && \
 echo 'UTC' > /etc/timezone && \
 dpkg-reconfigure tzdata && \
 apt-get upgrade --yes --force-yes

# Add the local artifactory instance to the apt sources lists
RUN echo deb http://artifactory.weedon.org.au/artifactory/debian-local xenial main >/etc/apt/sources.list.d/artifactory.list && \
    wget -qO - http://artifactory.weedon.org.au/artifactory/api/gpg/key/public | apt-key add -
