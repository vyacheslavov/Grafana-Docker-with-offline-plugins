FROM debian:jessie

#ARG GRAFANA_VERSION="latest"

ARG DOWNLOAD_URL="https://s3-us-west-2.amazonaws.com/grafana-releases/master/grafana_latest_amd64.deb"

#ENV GF_INSTALL_PLUGINS foursquare-clouderamanager-datasource

RUN apt-get update 
RUN  apt-get -y --no-install-recommends install libfontconfig curl ca-certificates 
RUN  apt-get clean 
#RUN  curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb 
RUN curl ${DOWNLOAD_URL} > /tmp/grafana.deb
RUN  dpkg -i /tmp/grafana.deb 
RUN  rm /tmp/grafana.deb 
RUN  curl -L https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 > /usr/sbin/gosu
RUN  chmod +x /usr/sbin/gosu 
RUN  apt-get autoremove -y 
RUN  rm -rf /var/lib/apt/lists/*
RUN ls ./
RUN ls /
RUN find / -iname "*run.sh"

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
