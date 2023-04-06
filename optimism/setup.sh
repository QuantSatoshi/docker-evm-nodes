# reference
# https://github.com/smartcontracts/simple-optimism-node
docker network create -d bridge geth || true

sudo mkdir -p /data/optimism/dtl
sudo mkdir -p /data/optimism/geth
sudo mkdir -p /data/optimism/op_geth
sudo mkdir -p /data/optimism/shared
sudo mkdir -p /data/optimism/prometheus_data
sudo mkdir -p /data/optimism/grafana
sudo mkdir -p /data/optimism/influxdb_data
sudo mkdir -p /data/optimism/grafana_data
sudo mkdir -p /data/optimism/torrent_config
sudo mkdir -p /data/optimism/torrent_downloads

docker compose up -d
