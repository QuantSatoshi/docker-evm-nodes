# prune db
docker run -d --name bor -v $(pwd)/config.toml:/root/config.toml -v /data/polygon/bor-home:/root/.bor 0xpolygon/bor:0.4.0-amd64 snapshot prune-state --datadir /root/.bor

