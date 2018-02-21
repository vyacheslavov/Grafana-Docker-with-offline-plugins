ARG GRAFANA_VERSION=latest
FROM grafana/grafana:${GRAFANA_VERSION}

#ARG GF_RUN_PLUGINS="grafana-cli --pluginsDir "/data/grafana/plugins" plugins install foursquare-clouderamanager-datasource"
ARG GF_RUN_PLUGINS


#ARG DOWNLOAD_URL="https://s3-us-west-2.amazonaws.com/grafana-releases/master/grafana_latest_amd64.deb"
#RUN  curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb 

RUN mkdir -p /data/grafana/plugins && chown -R grafana:grafana /data/grafana/plugins
#RUN grafana-cli --pluginsDir "/data/grafana/plugins" plugins install ${GF_INSTALL_PLUGINS}
RUN ${GF_RUN_PLUGINS}
