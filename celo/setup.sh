export CELO_IMAGE=us.gcr.io/celo-org/geth:mainnet
docker pull $CELO_IMAGE
mkdir -p /data/celo
mkdir -p /data/celo/data

cd /data/celo/data

docker run -v $(pwd):/root/.celo --rm -it $CELO_IMAGE account new

export CELO_ACCOUNT_ADDRESS=<>

