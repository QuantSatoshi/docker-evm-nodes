# configure these
NODE_NAME=heimdall1
docker network create -d bridge geth || true

# do not modify
FOLDER=/data/polygon
sudo mkdir -p ${FOLDER}/heimdall
docker run -it 0xpolygon/heimdall:latest heimdallcli version
docker run -v ${FOLDER}/heimdall:/heimdall-home:rw --entrypoint /usr/local/bin/heimdalld -it 0xpolygon/heimdall:latest init --home=/heimdall-home
echo "setup heimdall"
sudo cp ${FOLDER}/heimdall/config/config.toml ${FOLDER}/heimdall/config/config.toml.original
sudo chown -R $USER:$USER ${FOLDER}/heimdall/config
sed -i "s/moniker = \".*\"/moniker = \"${NODE_NAME}\"/" ${FOLDER}/heimdall/config/config.toml
sed -i 's/seeds = ""/seeds = "f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656,2eadba4be3ce47ac8db0a3538cb923b57b41c927@35.199.4.13:26656,3b23b20017a6f348d329c102ddc0088f0a10a444@35.221.13.28:26656,25f5f65a09c56e9f1d2d90618aa70cd358aa68da@35.230.116.151:26656"/' ${FOLDER}/heimdall/config/config.toml
sed -i "s/cors_allowed_origins = \[\]/cors_allowed_origins = \[\"\*\"\]/" ${FOLDER}/heimdall/config/config.toml
sed -i "s/laddr = \"tcp:\/\/127.0.0.1:26657\"/laddr = \"tcp:\/\/0.0.0.0:26657\"/" ${FOLDER}/heimdall/config/config.toml

sed -i 's/eth_rpc_url = "http:\/\/localhost:9545"/eth_rpc_url = "http:\/\/ethereum:8545"/' ${FOLDER}/heimdall/config/heimdall-config.toml
sed -i 's/bor_rpc_url = "http:\/\/localhost:8545"/bor_rpc_url = "http:\/\/bor:8545"/' ${FOLDER}/heimdall/config/heimdall-config.toml

sudo curl -o ${FOLDER}/heimdall/config/genesis.json https://raw.githubusercontent.com/maticnetwork/heimdall/develop/builder/files/genesis-mainnet-v1.json

sha256sum ${FOLDER}/heimdall/config/genesis.json

# optional, download snapshot
if [ ! -z "$DOWNLOAD_SNAP" ]; then
  wget -c https://matic-blockchain-snapshots.s3-accelerate.amazonaws.com/matic-mainnet/heimdall-snapshot-2022-12-07.tar.gz -O - | tar -xzf - -C ${FOLDER}/heimdall/data/
fi

#setup bor
echo "Setup bor..."
sudo mkdir -p ${FOLDER}/bor-home
sudo curl -o ${FOLDER}/bor-home/genesis.json 'https://raw.githubusercontent.com/maticnetwork/launch/master/mainnet-v1/sentry/sentry/bor/genesis.json'
docker run --rm -v ${FOLDER}/bor-home:/bor-home:rw -it 0xpolygon/bor:0.3.3-amd64 server --datadir /bor-home init /bor-home/genesis.json

# snapshot download
sudo mkdir -p ${FOLDER}/bor-home/bor
sudo chown -R $USER:$USER ${FOLDER}/bor-home/bor/chaindata
if [ ! -z "$DOWNLOAD_SNAP" ]; then
  wget -c https://matic-blockchain-snapshots.s3-accelerate.amazonaws.com/matic-mainnet/bor-fullnode-snapshot-2022-12-19.tar.gz  -O - | tar -xzf - -C ${FOLDER}/bor-home/bor/chaindata
fi

# if you are under a firewall
# open these ports 30304, 26656, 26657
