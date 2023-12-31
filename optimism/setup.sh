# reference
# https://github.com/smartcontracts/simple-optimism-node
docker network create -d bridge geth || true

mkdir -p /data/optimism/dtl
mkdir -p /data/optimism/geth
mkdir -p /data/optimism/op_geth
mkdir -p /data/optimism/shared
mkdir -p /data/optimism/prometheus_data
mkdir -p /data/optimism/grafana
mkdir -p /data/optimism/influxdb_data
mkdir -p /data/optimism/grafana_data
mkdir -p /data/optimism/torrent_config
mkdir -p /data/optimism/torrent_downloads

# for some reason you must specify all service names to start all
docker compose up -d l2geth healthcheck op-geth op-node bedrock-init  prometheus grafana influxdb
