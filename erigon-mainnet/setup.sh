mkdir -p /data/erigon/cmd
mkdir -p /data/erigon/cmd/prometheus
mkdir -p /data/erigon/prometheus
wget -O /data/erigon/cmd/prometheus/prometheus.yml https://raw.githubusercontent.com/prometheus/prometheus/main/documentation/examples/prometheus.yml


mkdir -p /data/erigon/cmd/grafana
mkdir -p /data/erigon/cmd/grafana/datasources
mkdir -p /data/erigon/cmd/grafana/dashboards
mkdir -p /data/erigon/erigon-grafana
wget -O /data/erigon/cmd/grafana/grafana.ini https://raw.githubusercontent.com/grafana/grafana/main/conf/defaults.ini
sudo chown -R 472:472 /data/erigon/cmd/grafana
sudo chown -R 472:472 /data/erigon/erigon-grafana

