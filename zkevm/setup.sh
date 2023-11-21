ZKEVM_NET=mainnet
ZKEVM_DIR=/data/zk-polygon
ZKEVM_CONFIG_DIR=/data/zk-polygon/config

mkdir -p ZKEVM_DIR
cd ZKEVM_DIR
curl -L https://github.com/0xPolygonHermez/zkevm-node/releases/latest/download/$ZKEVM_NET.zip > $ZKEVM_NET.zip && unzip -o $ZKEVM_NET.zip -d $ZKEVM_DIR && rm $ZKEVM_NET.zip
mkdir -p $ZKEVM_CONFIG_DIR && cp $ZKEVM_DIR/$ZKEVM_NET/example.env $ZKEVM_CONFIG_DIR/.env

# EDIT THIS env file, all folder location are for local path, not docker path
cd /data/zk-polygon/mainnet
vim .env

# RUN:

cd /data/zk-polygon/mainnet
docker compose up -d

# change the default ports for docker-compose.yml to avoid port conflict
