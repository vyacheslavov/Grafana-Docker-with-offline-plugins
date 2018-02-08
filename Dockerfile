FROM debian:jessie

ARG DOWNLOAD_URL

ENV GF_INSTALL_PLUGINS foursquare-clouderamanager-datasource

RUN apt-get update 
RUN  apt-get -y --no-install-recommends install libfontconfig curl ca-certificates 
RUN  apt-get clean 
RUN  curl ${DOWNLOAD_URL} > /tmp/grafana.deb 
RUN  dpkg -i /tmp/grafana.deb 
RUN  rm /tmp/grafana.deb 
RUN  curl -L https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 > /usr/sbin/gosu
RUN  chmod +x /usr/sbin/gosu 
RUN  apt-get autoremove -y 
RUN  rm -rf /var/lib/apt/lists/*
   

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

COPY ./run.sh /run.sh

ENTRYPOINT ["/run.sh"]
