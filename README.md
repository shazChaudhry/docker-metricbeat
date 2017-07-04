[![Build Status on Travis](https://travis-ci.org/shazChaudhry/docker-metricbeat.svg?branch=master)](https://travis-ci.org/shazChaudhry/docker-metricbeat "Build Status on Travis")
[![Docker Repository on Quay](https://quay.io/repository/shazchaudhry/docker-metricbeat/status "Docker Repository on Quay")](https://quay.io/repository/shazchaudhry/docker-metricbeat)

**User story**
* As a member of DevOps team I want collect and ship metrics (from CPU to memory) to Elasticsearch or Logstash so that I can visualize stats in Kibana.

**Assumptions**
* Your infrastructure is required to have [Docker Swarm cluster](https://docs.docker.com/get-started/part4/#understanding-swarm-clusters) configuration

**Prerequisite**
* Set up a development infrastructre by following [Infra as Code](https://github.com/shazChaudhry/infra) repo on github _(Optional as you might have your own infra already created)_
* Setup Elastic Stack by following [this](https://github.com/shazChaudhry/logging) github repo _(Optional as you might have your own services already created)_

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
  --name metricbeat \
  --volume metricmeat_data:/var/lib/metricbeat \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --env HOST=<HOSTNAME> \
  --env PORT=9200 \
  --env PROTOCOL=http \
  --env USERNAME=elastic \
  --env PASSWORD=changeme \
quay.io/shazchaudhry/docker-metricbeat
```

**Test**
* Running the following command should produce elasticsearch index and one of the rows should have _metricbeat-*_:
```
curl -XGET -u elastic:changeme '127.0.0.1:9200/_cat/indices?v&pretty'
```
* If not already available in Kibana, create an index called "metricmeat-*".

**Metricbeat overview, docs and FAQ**

* [Overview](https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-overview.html)
* [Running Metricbeat in a Container](https://www.elastic.co/guide/en/beats/metricbeat/5.x/running-in-container.html)
