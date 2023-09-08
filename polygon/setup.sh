# configure these
NODE_NAME=heimdall1
docker network create -d bridge geth || true

# do not modify
FOLDER=/data/polygon
sudo mkdir -p ${FOLDER}/heimdall
docker run -it 0xpolygon/heimdall:latest heimdallcli version
docker run -v ${FOLDER}/heimdall:/heimdall-home:rw --entrypoint /usr/bin/heimdalld -it 0xpolygon/heimdall:latest init --home=/heimdall-home
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

#  download snapshot
