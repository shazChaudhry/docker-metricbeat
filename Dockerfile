FROM docker.elastic.co/beats/metricbeat:5.5.0
COPY config/metricbeat.yml /usr/share/metricbeat
USER root
RUN chmod go-w /usr/share/metricbeat/metricbeat.yml
USER metricbeat
