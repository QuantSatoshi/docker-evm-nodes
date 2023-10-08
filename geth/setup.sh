docker network create -d bridge geth || true
sudo mkdir -p /data/geth
sudo chown $USER:$USER /data/geth
cd /data/geth
if [ -f "jwtsecret" ]; then
  echo "jwtsecret exists."
else
  echo "creating new jwtsecret"
  openssl rand -hex 32 > jwtsecret
fi
