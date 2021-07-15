FROM debian:stable-slim

ENV HLSPROXY_VERSION="7.7.1" \
  TZ="Europe/Tallinn" \
  DEBIAN_FRONTEND=noninteractive
WORKDIR /opt/hlsp
VOLUME [ "/opt/hlsp" ]

EXPOSE 88

RUN \
apt-get update && apt-get upgrade -y && \
apt-get install -y \
unzip \
wget \
nano &&\
#tzdata && \
#ln -fs /usr/share/zoneinfo/%{TZ} /etc/localtime && \
#dpkg-reconfigure --frontend noninteractive tzdata && \
apt-get autoremove -y && \
wget -o - https://www.hls-proxy.com/downloads/${HLSPROXY_VERSION}/hls-proxy-${HLSPROXY_VERSION}.linux-x64.zip -O hlsproxy.zip && \
unzip hlsproxy.zip -d /opt/hlsp/ && \
chmod +x /opt/hlsp/hls-proxy && \
/opt/hlsp/hls-proxy -address 0.0.0.0 -port 88 -save -quit

CMD ["/opt/hlsp/hls-proxy"]
