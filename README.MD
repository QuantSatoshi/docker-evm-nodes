# Run ethereum geth node in docker
# Run arbitrum, polygon node in docker

This repo helps you to quickly deploy nodes in any linux env

All data will be store in /data folder

You should mount or link /data folder to a large ssd drive

## Start geth
```
cd geth
bash setup.sh
docker compose up -d
```

## Start polygon
You must start geth first, and synced up to date

```
cd polygon
#If you want to setup with downloading snapshot, do this:
DOWNLOAD_SNAP=true bash setup.sh
# no snapshot downloading
bash setup.sh
docker compose up -d
```

## Start arbitrum
You must start geth first, and synced up to date
```
cd arbitrum
bash setup.sh
docker compose up -d
```


## Start Optimism
This is not tested.
check the files in optimism folder.


## Start erigon full arhive node for ethereum mainet
```
cd erigon-mainet
bash setup.sh
docker compose up -d
```


## useful debug commands
```
#attach geth
docker exec -it ethereum geth attach
eth.syncing

```