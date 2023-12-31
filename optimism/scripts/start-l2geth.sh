#!/bin/sh
set -eou

# Start l2geth.
exec geth \
  --vmodule=eth/*=5,miner=4,rpc=5,rollup=4,consensus/clique=1 \
  --datadir=$DATADIR \
  --password=$DATADIR/password \
  --allow-insecure-unlock \
  --unlock=$BLOCK_SIGNER_ADDRESS \
  --mine \
  --miner.etherbase=$BLOCK_SIGNER_ADDRESS \
  --gcmode=$NODE_TYPE \
  --metrics \
  --metrics.influxdb \
  --metrics.influxdb.endpoint=http://influxdb:8086 \
  --metrics.influxdb.database=l2geth \
  $@
