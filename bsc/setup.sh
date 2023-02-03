sudo mkdir -p /data/bsc
sudo chown $USER:$USER /data/bsc
mkdir -p /data/bsc/config
OLD_PATH=$(pwd)
cd ~
git clone https://github.com/bnb-chain/bsc.git || true
cd ~/bsc
docker build -t bsc .

cd $OLD_PATH
cp ./config.toml /data/bsc/config
cp ./genesis.json /data/bsc/config
sudo chmod -R 777 /data/bsc
docker run -it --rm -v /data/bsc/config:/bsc/config -v /data/bsc/node:/bsc/node bsc --datadir node init config/genesis.json

docker network create -d bridge geth || true
