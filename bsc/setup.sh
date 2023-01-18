sudo mkdir -p /data/bsc
sudo chown $USER:$USER /data/bsc

cd ~
git clone https://github.com/bnb-chain/bsc.git || true
cd ~/bsc
docker build -t bsc .
