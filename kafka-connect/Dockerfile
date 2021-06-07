FROM confluentinc/cp-server-connect-base:6.1.1

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

ARG CONNECTOR_NAME
ARG CONNECTOR_VERSION
RUN confluent-hub install --no-prompt confluentinc/${CONNECTOR_NAME}:${CONNECTOR_VERSION}

CMD ["/etc/confluent/docker/run"]