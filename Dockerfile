FROM debian

ARG METRICBEAT_VERSION=5.x

RUN set -x && \
  apt-get update && \
  apt-get install -y wget gnupg  && \
  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
  apt-get install -y apt-transport-https && \
  echo "deb https://artifacts.elastic.co/packages/${METRICBEAT_VERSION}/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-${METRICBEAT_VERSION}.list && \
  apt-get update && apt-get install -y metricbeat

COPY config/metricbeat.yml /etc/metricbeat
RUN chmod go-w /etc/metricbeat/metricbeat.yml

ENTRYPOINT [ "/usr/share/metricbeat/bin/metricbeat" ]
CMD [ "-e", "-setup", "-path.config", "/etc/metricbeat", "-path.data", "/var/lib/metricbeat", "-path.logs", "/var/log/metricbeat" ]
