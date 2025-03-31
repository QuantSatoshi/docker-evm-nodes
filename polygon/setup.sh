# configure these
NODE_NAME=heimdall1
docker network create -d bridge geth || true

# do not modify
sudo mkdir -p /data/polygon/heimdall
docker run -v /data/polygon/heimdall:/heimdall-home:rw --entrypoint /usr/bin/heimdalld -it 0xpolygon/heimdall:1.2.1 init --home=/heimdall-home
echo "setup heimdall"
sudo chown -R $USER:$USER /data/polygon/heimdall/config

cp /data/polygon/heimdall/config/config.toml /data/polygon/heimdall/config/config.toml.original
sed -i "s/moniker = \".*\"/moniker = \"${NODE_NAME}\"/" /data/polygon/heimdall/config/config.toml
sed -i 's/seeds = ""/seeds = "f4f605d60b8ffaaf15240564e58a81103510631c@159.203.9.164:26656,4fb1bc820088764a564d4f66bba1963d47d82329@44.232.55.71:26656,2eadba4be3ce47ac8db0a3538cb923b57b41c927@35.199.4.13:26656,3b23b20017a6f348d329c102ddc0088f0a10a444@35.221.13.28:26656,25f5f65a09c56e9f1d2d90618aa70cd358aa68da@35.230.116.151:26656,1500161dd491b67fb1ac81868952be49e2509c9f@52.78.36.216:26656,dd4a3f1750af5765266231b9d8ac764599921736@3.36.224.80:26656,8ea4f592ad6cc38d7532aff418d1fb97052463af@34.240.245.39:26656,e772e1fb8c3492a9570a377a5eafdb1dc53cd778@54.194.245.5:26656,6726b826df45ac8e9afb4bdb2469c7771bd797f1@52.209.21.164:26656,d3a8990f61bb3657da1664fe437d4993c4599a7e@3.211.248.31:26656"/' /data/polygon/heimdall/config/config.toml
sed -i "s/cors_allowed_origins = \[\]/cors_allowed_origins = \[\"\*\"\]/" /data/polygon/heimdall/config/config.toml
sed -i "s/laddr = \"tcp:\/\/127.0.0.1:26657\"/laddr = \"tcp:\/\/0.0.0.0:26657\"/" /data/polygon/heimdall/config/config.toml

sed -i 's/eth_rpc_url = "http:\/\/localhost:9545"/eth_rpc_url = "http:\/\/ethereum:8545"/' /data/polygon/heimdall/config/heimdall-config.toml
sed -i 's/bor_rpc_url = "http:\/\/localhost:8545"/bor_rpc_url = "http:\/\/bor:8545"/' /data/polygon/heimdall/config/heimdall-config.toml

# you may need to copy config/addrbook.json from another server to get peers faster

sudo curl -o /data/polygon/heimdall/config/genesis.json https://raw.githubusercontent.com/maticnetwork/heimdall/develop/builder/files/genesis-mainnet-v1.json

sha256sum /data/polygon/heimdall/config/genesis.json
# 498669113c72864002c101f65cd30b9d6b159ea2ed4de24169f1c6de5bcccf14
#  polygon genesis
sudo curl -o /data/polygon/bor-home/genesis.json 'https://raw.githubusercontent.com/maticnetwork/bor/master/builder/files/genesis-mainnet-v1.json'

sha256sum /data/polygon/bor-home/genesis.json

# expected genesis
# 49aaa555ffdaa30aacd0bc0312bd3d134d6a72aa4b2113230e8c394a82652d5b

# exec interactive
docker exec -it bor bor attach /root/.bor/bor.ipc



# reset heimdall
# docker run -v /data/polygon/heimdall:/heimdall-home:rw --entrypoint /usr/bin/heimdalld -it 0xpolygon/heimdall:0.3.5 unsafe-reset-all

