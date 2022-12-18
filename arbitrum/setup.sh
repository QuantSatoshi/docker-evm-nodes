sudo mkdir -p /data/arbitrum
docker network create -d bridge geth || true
yarn
node updateTag.js
