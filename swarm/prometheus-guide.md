# First lets get Node Exporter
# Prometheus exporter for hardware and OS metrics exposed by *NIX kernels, written in Go with pluggable metric collectors.

      docker run -d \
        --net="host" \
        --pid="host" \
        -v "/:/host:ro,rslave" \
        quay.io/prometheus/node-exporter:latest \
        --path.rootfs=/host

For Docker compose, similar flag changes are needed.

      version: '3.8'

      services:
        node_exporter:
          image: quay.io/prometheus/node-exporter:latest
          container_name: node_exporter
          command:
            - '--path.rootfs=/host'
          network_mode: host
          pid: host
          restart: unless-stopped
          volumes:
            - '/:/host:ro,rslave'


# Second Step

# Running Prometheus on Docker 
    docker run -d --name prometheus -p 9090:9090 -v $PWD/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
# This starts Prometheus with a sample configuration and exposes it on port 9090.

# Third Step 
Running your Grafana container
      docker run -d --name=grafana -p 3000:3000 grafana/grafana
