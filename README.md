[![Build Status on Travis](https://travis-ci.org/shazChaudhry/docker-metricbeat.svg?branch=master)](https://travis-ci.org/shazChaudhry/docker-metricbeat "Build Status on Travis")
[![Docker Repository on Quay](https://quay.io/repository/shazchaudhry/docker-metricbeat/status "Docker Repository on Quay")](https://quay.io/repository/shazchaudhry/docker-metricbeat)

**User story**
* As a member of DevOps team, I want to collect and ship metrics (from CPU to memory) to Elastic stack so that I can visualize stats in Kibana.

**Prerequisite**
* ELK v5.5.1 (Elasticsearch, Logstash and Kibana) is up and running
* Elasticsearch port is open for metricbeat to send logs to
* Latest version of Docker is installed (this metricbeat image has been tested on Docker 17.06.0-ce)


**System-Level Monitoring**<br>
Deploy Metricbeat on all your hosts, connect it to Elasticsearch and voila: you get system-level CPU usage, memory, file system, disk IO, and network IO statistics, as well as top-like statistics for every process running on your systems.

Before building metricbeat image, please take a look at config/metricbeat.yml to ensure it is configured as appropriate for your system or as per your requirements:
```
docker image build \
  --rm --no-cache \
  --tag quay.io/shazchaudhry/docker-metricbeat .
```
Start the container that will forward metricbeat to Elasticsearch:
```
docker container run -d --rm \
  --name metricbeat \
  --volume metricbeat_data:/usr/share/metricbeat/data \
  --volume=/proc:/hostfs/proc:ro \
  --volume=/sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro \
  --volume=/:/hostfs:ro \
  --network=host \
  --env HOST=<elasticsearch_host> \
  --env PORT=<elasticsearch_port> \
  --env PROTOCOL=<http_or_https> \
  --env USERNAME=<username> \
  --env PASSWORD=<password> \
quay.io/shazchaudhry/docker-metricbeat
```

**Test**
* Running the following command should produce elasticsearch index and one of the rows should have _metricbeat-*_:
```
curl -XGET -u elastic:changeme '<elasticsearch_host>:9200/_cat/indices?v&pretty'
curl -XGET -u elastic:changeme '<elasticsearch_host>:9200/metricbeat-*/_search?pretty'
```
* If not already available in Kibana, create an index called "metricmeat-*".

**Metricbeat overview, docs and FAQ**

* [Overview - https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-overview.html](https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-overview.html)
