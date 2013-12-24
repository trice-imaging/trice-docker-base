FROM stackbrew/ubuntu:13.10
MAINTAINER John Axel Eriksson <john@insane.se>

ENV DEBIAN_FRONTEND noninteractive

ADD bootstrap.sh /root/bootstrap.sh
RUN chmod +x /root/bootstrap.sh && /root/bootstrap.sh && rm /root/bootstrap.sh # 2013-12-24