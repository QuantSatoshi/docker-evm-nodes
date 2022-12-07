# start geth
```
cd geth
bash setup.sh
docker compose up -d
```

# start polygon
You must start geth first, and synced up to date

```
cd polygon
#If you want to setup with downloading snapshot, do this:
DOWNLOAD_SNAP=true bash setup.sh
# no snapshot downloading
bash setup.sh
```

