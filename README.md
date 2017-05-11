[![Build Status on Travis](https://travis-ci.org/shazChaudhry/docker-metricbeat.svg?branch=master)](https://travis-ci.org/shazChaudhry/docker-metricbeat "Build Status on Travis")
[![Docker Repository on Quay](https://quay.io/repository/shazchaudhry/docker-metricbeat/status "Docker Repository on Quay")](https://quay.io/repository/shazchaudhry/docker-metricbeat)

**User story**

**Assumptions**
* Your infrastructure is required to be based on ubuntu/xenial64
* Your infrastructure is required to have [Docker Swarm cluster](https://docs.docker.com/get-started/part4/#understanding-swarm-clusters) configuration

**Prerequisite**
* Set up a development infrastructre by following [Infra as Code](https://github.com/shazChaudhry/infra) repo on github
* Setup Elastic Stack by following [this](https://github.com/shazChaudhry/logging) github repo

**Requirements**
* Ensure Elasticsearch, (_Logstash optional_) and Kibana are up and running

Build metricmeat image ensurinig that config/metricmeat.yml is configured as appropriate for your system or as per your requirements:
```
export METRICBEAT_VERSION=5.x
docker build \
  --rm --no-cache \
  --build-arg METRICBEAT_VERSION=${METRICBEAT_VERSION} \
  --tag quay.io/shazchaudhry/docker-metricbeat .
```
Start the container that will forward metricmeat to Elastic search:
```
docker run -d --rm \
  --name filebeat \
  --volume metricmeat_data:/var/lib/metricmeat \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --env HOST=node1 \
  --env PORT=9200 \
  --env PROTOCOL=http \
  --env USERNAME=elastic \
  --env PASSWORD=changeme \
quay.io/shazchaudhry/docker-metricbeat
```

If not already available in Kibana, create an index called "metricmeat-*".

**Test**

**Metricbeat overview, docs and FAQ**

* [Overview](https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-overview.html)
* [Running Metricbeat in a Container](https://www.elastic.co/guide/en/beats/metricbeat/5.x/running-in-container.html)
