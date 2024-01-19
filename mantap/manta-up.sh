#!/usr/bin/env bash

set -eu
# setup L1_RPC_URL=xxx in .env
source .env

L2_URL="http://localhost:9777"
OP_NODE="$PWD/op-node"

# Helper method that waits for a given URL to be up. Can't use
# cURL's built-in retry logic because connection reset errors
# are ignored unless you're using a very recent version of cURL
function wait_up {
  echo -n "Waiting for $1 to come up..."
  i=0
  until curl -s -f -o /dev/null "$1"
  do
    echo -n .
    sleep 0.25

    ((i=i+1))
    if [ "$i" -eq 300 ]; then
      echo " Timeout!" >&2
      exit 1
    fi
  done
  echo "Done!"
}

# Bring up L2.
(
  echo "Bringing up L2..."
  docker compose -f docker-compose.yml up -d manta-l2
  wait_up $L2_URL
)

# Bring up everything else.
(
  echo "Bringing up L2 services..."
  docker compose up -d manta-op-node
)

echo "L2 ready."