[![Build Status on Travis](https://travis-ci.org/shazChaudhry/docker-metricbeat.svg?branch=master)](https://travis-ci.org/shazChaudhry/docker-metricbeat "Build Status on Travis")
[![Docker Repository on Quay](https://quay.io/repository/shazchaudhry/docker-metricbeat/status "Docker Repository on Quay")](https://quay.io/repository/shazchaudhry/docker-metricbeat)

#### User story
As a member of DevOps team, I want to collect and ship metrics to Elasticsearch so that I can visualize stats in Kibana

The Beats are open source data shippers that you install as agents on your servers to send different types of operational data to Elasticsearch. Beats can send data directly to Elasticsearch or send it to Elasticsearch via Logstash, which you can use to parse and transform the data.

<p align="center">
  <img src="./pics/beats-platform.png" alt="Beats platform" style="width: 250px;"/>
</p>

In this repository, the intended use case for Metricbeat is to push logs directly Elasticsearch

#### Prerequisite
* Elastic stack v6.0 is up and running
* Elasticsearch port 9200 is open for metricbeat to send logs to
* Metricbeat is being installed on the same server as Elasticsearch
* Latest version of Docker is installed
* On each node where metricbeat is to be run, grant explicit access to the Metricbeat user with a filesystem ACL by running `sudo setfacl -m u:1000:rw /var/run/docker.sock` command. Otherwise, docker stats will not be shown. A workround (if previous command did not work) is to set `sudo chmod 666 /var/run/docker.sock` on all nodes

#### System-Level Monitoring
Deploy Metricbeat on all your hosts, connect it to Elasticsearch and voila: you get system-level CPU usage, memory, file system, disk IO, and network IO statistics, as well as top-like statistics for every process running on your systems.

Before building metricbeat image, please take a look at config/metricbeat.yml to ensure it is configured as appropriate for your system or as per your requirements:
```
docker image build \
  --rm --no-cache \
  --tag quay.io/shazchaudhry/docker-metricbeat:6.0.0 .
```
Start the container that will forward metricbeat stats to Elasticsearch:
```
docker container run -d --rm \
--name metricbeat \
--volume=/proc:/hostfs/proc:ro \
--volume=/sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro \
--volume=/:/hostfs:ro \
--volume=/var/run/docker.sock:/var/run/docker.sock \
--volume metricbeat_data:/usr/share/metricbeat/data \
--network=host \
quay.io/shazchaudhry/docker-metricbeat:6.0.0 metricbeat -e -system.hostfs=/hostfs
```

#### Test
* Running the following command should produce elasticsearch index and one of the rows should have _metricbeat-*_:
```
curl -XGET -u elastic:changeme 'localhost:9200/_cat/indices?v&pretty'
curl -XGET -u elastic:changeme 'localhost:9200/metricbeat-*/_search?pretty'
```
* If not already available in Kibana, create an index called "metricmeat-*".

**Metricbeat overview, docs and FAQ**

* [Overview - https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-overview.html](https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-overview.html)
