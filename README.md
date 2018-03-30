# Grafana Docker with offline plugins

This project builds a Docker image with Grafana and runs container with predefined and dowloaded Grafana plugins without accessing the Internet.

## Prerequisites

The Dockerfile has to access the given arguments before pulling the Dockerfile from the official repository. This functionality requires Docker Community Edition of the minimum version 17.05.0-ce. Installation guide can be found [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce).

## Building your Grafana image

Bash script has 3 input arguments:  a comma seperated list of plugins, image tag, version of Grafana. 

By default (without any input arguments) the script builds an image with Grafana of the "latest" version, without plugins and with an image tag "master":

```
bash build.sh
```

The example of input input arguments (Antonios, use this one):

```
bash build.sh foursquare-clouderamanager-datasource master latest
```

You can define the list of plugins separating them by comma without spaces. For example: 

```
bash build.sh foursquare-clouderamanager-datasource,grafana-simple-json-datasource master latest
```

## Running container with offline plugins

~~Pass the plugins you want installed to docker with the `GF_INSTALL_PLUGINS` environment variable as a comma seperated list. Here you can select the plugins to be installed into container. You can install only those plugins that were downloaded during building process.~~

You do not need to specify the plugins again during starting of the container from the built image. Only if you want to download (e.g. you will need Internet access) additional plugins or update already downloaded ones, you can do it by passing them through the `GF_INSTALL_PLUGINS` environment variable as a comma separated list.

Also, make sure to specify the image tag. If you did not pass the tag argument during the building process, use the default tag – "master". Here is example command:

```
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  grafana/grafana:master
```

This command is available as a bash script in this repo:

```
bash start_container.sh
```

## Grafana container with persistent storage (recommended)

```
# create /var/lib/grafana as persistent volume storage
docker run -d -v /var/lib/grafana --name grafana-storage busybox:latest

# start grafana
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  --volumes-from grafana-storage \
  grafana/grafana:master
```

## Configuring AWS credentials for CloudWatch support

```
docker run \
  -d \
  -p 3000:3000 \
  --name=grafana \
  -e "GF_AWS_PROFILES=default" \
  -e "GF_AWS_default_ACCESS_KEY_ID=YOUR_ACCESS_KEY" \
  -e "GF_AWS_default_SECRET_ACCESS_KEY=YOUR_SECRET_KEY" \
  -e "GF_AWS_default_REGION=us-east-1" \
  grafana/grafana:master
```

You may also specify multiple profiles to `GF_AWS_PROFILES` (e.g.
`GF_AWS_PROFILES=default another`).

Supported variables:

- `GF_AWS_${profile}_ACCESS_KEY_ID`: AWS access key ID (required).
- `GF_AWS_${profile}_SECRET_ACCESS_KEY`: AWS secret access  key (required).
- `GF_AWS_${profile}_REGION`: AWS region (optional).

