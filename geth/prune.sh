
docker stop ethereum --time 600
docker rm -f ethereum || true
docker run -d --name eth-prune -v /data/geth:/root/.ethereum mev-geth snapshot prune-state
dockerf ethereum
