git clone https://github.com/base-org/node.git base
cd base
docker build -t base -f geth/Dockerfile .

cd ../docker-evm-nodes/base

docker compose up -d
