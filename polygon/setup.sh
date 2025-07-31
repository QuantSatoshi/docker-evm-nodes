# configure these
NODE_NAME=heimdall1
docker network create -d bridge geth || true

# do not modify
sudo mkdir -p /data/polygon/heimdall
docker run -v /data/polygon/heimdall:/heimdall-home:rw --entrypoint /usr/bin/heimdalld -it 0xpolygon/heimdall-v2:0.2.9 init ${NODE_NAME} --home=/heimdall-home
echo "setup heimdall"
sudo chown -R $USER:$USER /data/polygon/heimdall/config

cp /data/polygon/heimdall/config/config.toml /data/polygon/heimdall/config/config.toml.original
sed -i 's/seeds = ""/seeds = "e019e16d4e376723f3adc58eb1761809fea9bee0@35.234.150.253:26656,7f3049e88ac7f820fd86d9120506aaec0dc54b27@34.89.75.187:26656,1f5aff3b4f3193404423c3dd1797ce60cd9fea43@34.142.43.249:26656,2d5484feef4257e56ece025633a6ea132d8cadca@35.246.99.203:26656,17e9efcbd173e81a31579310c502e8cdd8b8ff2e@35.197.233.240:26656,72a83490309f9f63fdca3a0bef16c290e5cbb09c@35.246.95.65:26656,00677b1b2c6282fb060b7bb6e9cc7d2d05cdd599@34.105.180.11:26656,721dd4cebfc4b78760c7ee5d7b1b44d29a0aa854@34.147.169.102:26656,4760b3fc04648522a0bcb2d96a10aadee141ee89@34.89.55.74:26656"/' /data/polygon/heimdall/config/config.toml
sed -i 's/persistent_peers = ""/persistent_peers = "e019e16d4e376723f3adc58eb1761809fea9bee0@35.234.150.253:26656,7f3049e88ac7f820fd86d9120506aaec0dc54b27@34.89.75.187:26656,1f5aff3b4f3193404423c3dd1797ce60cd9fea43@34.142.43.249:26656,2d5484feef4257e56ece025633a6ea132d8cadca@35.246.99.203:26656,17e9efcbd173e81a31579310c502e8cdd8b8ff2e@35.197.233.240:26656,72a83490309f9f63fdca3a0bef16c290e5cbb09c@35.246.95.65:26656,00677b1b2c6282fb060b7bb6e9cc7d2d05cdd599@34.105.180.11:26656,721dd4cebfc4b78760c7ee5d7b1b44d29a0aa854@34.147.169.102:26656,4760b3fc04648522a0bcb2d96a10aadee141ee89@34.89.55.74:26656"/' /data/polygon/heimdall/config/config.toml
sed -i "s/cors_allowed_origins = \[\]/cors_allowed_origins = \[\"\*\"\]/" /data/polygon/heimdall/config/config.toml
sed -i "s/laddr = \"tcp:\/\/127.0.0.1:26657\"/laddr = \"tcp:\/\/0.0.0.0:26657\"/" /data/polygon/heimdall/config/config.toml

sed -i 's/eth_rpc_url = "http:\/\/localhost:9545"/eth_rpc_url = "http:\/\/ethereum:8545"/' /data/polygon/heimdall/config/app.toml
sed -i 's/bor_rpc_url = "http:\/\/localhost:8545"/bor_rpc_url = "http:\/\/bor:8545"/' /data/polygon/heimdall/config/app.toml

# you may need to copy config/addrbook.json from another server to get peers faster

sudo curl -o /data/polygon/heimdall/config/genesis.json https://raw.githubusercontent.com/maticnetwork/heimdall/develop/builder/files/genesis-mainnet-v1.json

sha256sum /data/polygon/heimdall/config/genesis.json
# 498669113c72864002c101f65cd30b9d6b159ea2ed4de24169f1c6de5bcccf14
# may need to update heimdall seeds from https://github.com/0xPolygon/heimdall-v2/blob/4d0492767829b9fa6b586300d95b0dfde253d6c3/packaging/templates/config/mainnet/config.toml

#  polygon genesis
sudo curl -o /data/polygon/bor-home/genesis.json 'https://raw.githubusercontent.com/maticnetwork/bor/master/builder/files/genesis-mainnet-v1.json'

sha256sum /data/polygon/bor-home/genesis.json

# expected genesis
# 49aaa555ffdaa30aacd0bc0312bd3d134d6a72aa4b2113230e8c394a82652d5b

# exec interactive
docker exec -it bor bor attach /root/.bor/bor.ipc



# reset heimdall
# docker run -v /data/polygon/heimdall:/heimdall-home:rw --entrypoint /usr/bin/heimdalld -it 0xpolygon/heimdall:0.3.5 unsafe-reset-all

