#!/bin/bash

docker run -d -p 3000:3000 \
  --name=grafana \
  grafana/grafana:master

#  -e "GF_INSTALL_PLUGINS=foursquare-clouderamanager-datasource" \

