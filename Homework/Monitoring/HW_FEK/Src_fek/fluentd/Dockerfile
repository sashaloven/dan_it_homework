# Use the official Fluentd image as the base
FROM fluent/fluentd:v1.17-1

# Set user to root to install plugins
USER root

# Install Fluentd plugins for Elasticsearch
RUN gem uninstall -I elasticsearch
RUN gem install elasticsearch -v 7.17.0
RUN gem install fluent-plugin-elasticsearch --no-document \
    && gem install fluent-plugin-record-modifier --no-document \
    && gem install fluent-plugin-json-in-json --no-document 

# Create Fluentd configuration directory
RUN mkdir -p /fluentd/etc

# Copy Fluentd configuration file
COPY fluent.conf /fluentd/etc/

# Set permissions and change back to fluent user
RUN chown -R fluent /fluentd && chmod -R 777 /fluentd
USER fluent

# Set Fluentd to use the custom configuration
CMD ["fluentd", "-c", "/fluentd/etc/fluent.conf"]
