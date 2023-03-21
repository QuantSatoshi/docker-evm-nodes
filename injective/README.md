cd /data/injective
mkdir /data/injective/injectived

wget https://tools.highstakes.ch/files/injective.tar.gz
tar -xvf injective.tar.gz -C /data/injective/injectived

wget https://raw.githubusercontent.com/InjectiveLabs/mainnet-config/master/10001/genesis.json -O /data/injective/injectived/config/genesis.json

docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d injective-core
