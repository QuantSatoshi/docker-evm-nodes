
docker rm -f bor-prune || true
docker run -d --name bor-prune -v /data/polygon/bor-home:/root/.bor -v /data/polygon/ancient:/root/.bor/bor/chaindata/ancient 0xpolygon/bor:1.5.3 snapshot prune-state --datadir /root/.bor
dockerf bor-prune
