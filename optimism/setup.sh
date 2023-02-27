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

cd ~
git clone https://github.com/smartcontracts/simple-optimism-node.git
cd simple-optimism-node
cp -r .env envs scripts docker ~/docker-evm-nodes/optimism

NETWORK_NAME=mainnet docker compose up -d
