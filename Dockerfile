FROM docker.elastic.co/beats/metricbeat:5.5.1
COPY config/metricbeat.yml /usr/share/metricbeat
USER root
RUN chown metricbeat /usr/share/metricbeat/metricbeat.yml && chmod go-w /usr/share/metricbeat/metricbeat.yml

USER metricbeat
