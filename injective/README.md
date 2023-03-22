## follow guide
https://injective.notion.site/Injective-Exchange-Service-Setup-Guide-7e59980634d54991862300670583d46a#2dc6c99dff2145f681366b8ff3ecf178

```
cd /data/injective
mkdir /data/injective/injectived
```

```
cd ./injective
docker compose -f docker-compose.yaml -f addons/docker-compose.provisioner.yaml up -d provisioner
```
wait for the provisioner done

```
wget https://tools.highstakes.ch/files/injective.tar.gz
tar -xvf injective.tar.gz -C /data/injective/injectived

wget https://raw.githubusercontent.com/InjectiveLabs/mainnet-config/master/10001/genesis.json -O /data/injective/injectived/config/genesis.json

docker compose -f docker-compose.yaml -f docker-compose.prod.yaml up -d --remove-orphans mongo injective-core

```

