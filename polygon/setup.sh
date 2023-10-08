# configure these
NODE_NAME=heimdall1
docker network create -d bridge geth || true

# do not modify
sudo mkdir -p /data/polygon/heimdall
docker run -it 0xpolygon/heimdall:0.3.4 heimdallcli version
docker run -v /data/polygon/heimdall:/heimdall-home:rw --entrypoint /usr/bin/heimdalld -it 0xpolygon/heimdall:0.3.4 init --home=/heimdall-home
echo "setup heimdall"
sudo cp /data/polygon/heimdall/config/config.toml /data/polygon/heimdall/config/config.toml.original
sudo chown -R $USER:$USER /data/polygon/heimdall/config
sed -i "s/moniker = \".*\"/moniker = \"${NODE_NAME}\"/" /data/polygon/heimdall/config/config.toml
sed -i 's/seeds = ""/seeds = "f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656,2eadba4be3ce47ac8db0a3538cb923b57b41c927@35.199.4.13:26656,3b23b20017a6f348d329c102ddc0088f0a10a444@35.221.13.28:26656,25f5f65a09c56e9f1d2d90618aa70cd358aa68da@35.230.116.151:26656"/' /data/polygon/heimdall/config/config.toml
sed -i "s/cors_allowed_origins = \[\]/cors_allowed_origins = \[\"\*\"\]/" /data/polygon/heimdall/config/config.toml
sed -i "s/laddr = \"tcp:\/\/127.0.0.1:26657\"/laddr = \"tcp:\/\/0.0.0.0:26657\"/" /data/polygon/heimdall/config/config.toml

sed -i 's/eth_rpc_url = "http:\/\/localhost:9545"/eth_rpc_url = "http:\/\/ethereum:8545"/' /data/polygon/heimdall/config/heimdall-config.toml
sed -i 's/bor_rpc_url = "http:\/\/localhost:8545"/bor_rpc_url = "http:\/\/bor:8545"/' /data/polygon/heimdall/config/heimdall-config.toml

sudo curl -o /data/polygon/heimdall/config/genesis.json https://raw.githubusercontent.com/maticnetwork/heimdall/develop/builder/files/genesis-mainnet-v1.json

sha256sum /data/polygon/heimdall/config/genesis.json

#  polygon genesis
sudo curl -o /data/polygon/bor-home/genesis.json 'https://raw.githubusercontent.com/maticnetwork/bor/master/builder/files/genesis-mainnet-v1.json'

sha256sum /data/polygon/bor-home/genesis.json

# expected genesis
# 49aaa555ffdaa30aacd0bc0312bd3d134d6a72aa4b2113230e8c394a82652d5b

# exec interactive
docker exec -it bor bor attach /root/.bor/bor.ipc




