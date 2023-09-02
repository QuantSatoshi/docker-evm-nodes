
docker rm -f bor-prune || true
docker run -d --name bor-prune -v /data/polygon/bor-home:/root/.bor 0xpolygon/bor:0.4.0-amd64 snapshot prune-state --datadir /root/.bor
dockerf bor-prune
