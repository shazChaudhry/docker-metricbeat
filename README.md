**WIP**


**User story**

**Assumptions**

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
  --tag quay.io/shazchaudhry/docker-metricmeat .
```
Start the container that will forward metricmeat to Elastic search:
```
docker run -d --rm \
  --name filebeat \
  --volume metricmeat_data:/var/lib/metricmeat \
  --env HOST=node1 \
  --env PORT=9200 \
  --env PROTOCOL=http \
  --env USERNAME=elastic \
  --env PASSWORD=changeme \
quay.io/shazchaudhry/docker-metricmeat
```

If not already available in Kibana, create an index called "filebeat-*" to view Jenkins' build logs.

**Test**

**Metricbeat overview, docs and FAQ**

* https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-overview.html
