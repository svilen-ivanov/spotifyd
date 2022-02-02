FROM ubuntu:20.04
RUN sed -i 's|http://archive.|http://bg.archive.|g' /etc/apt/sources.list
RUN apt-get -y update && apt-get -y dist-upgrade
RUN mkdir /root/spotify
COPY . /root/spotifyd

CMD /root/spotifyd/build-aarch64.sh
