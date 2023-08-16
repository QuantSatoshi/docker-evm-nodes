#!/bin/bash

function validate_client() {
  if [[ "$1" != "heimdall" && "$1" != "bor" ]]; then
    echo "Invalid client input. Please enter 'heimdall' or 'bor'."
    exit 1
  fi
}
read -p "Client Type (heimdall/bor): " client_input
validate_client "$client_input"
read -p "Directory to Download/Extract: " extract_dir_input

# set default values if user input is blank
network=mainnet
client=${client_input:-heimdall}
extract_dir=${extract_dir_input:-"${client}_extract"}

# install dependencies and cursor to extract directory
mkdir -p "$extract_dir"
cd "$extract_dir"

rm -rf "$extract_dir$client-$network-incremental-compiled-files.txt"
# download compiled incremental snapshot files list
aria2c -x6 -s6 "https://snapshot-download.polygon.technology/$client-$network-incremental-compiled-files.txt"

# download all incremental files, includes automatic checksum verification per increment
aria2c -x6 -s6 --max-download-limit=50M -c --auto-file-renaming=false --max-tries=100 -i $client-$network-incremental-compiled-files.txt

# Don't extract if download failed
if [ $? -ne 0 ]; then
    echo "Download failed. Restart the script to resume downloading."
    exit 1
fi

if [ $client = "heimdall" ]; then
	EXTRACT_DIR=/data/polygon/heimdall/data
fi

if [ $client = "bor" ]; then
	EXTRACT_DIR=/data/polygon/bor-home/snap
fi

mkdir -p $EXTRACT_DIR

# helper method to extract all files and delete already-extracted download data to minimize disk use
function extract_files() {
    compiled_files=$1
    while read -r line; do
        if [[ "$line" == checksum* ]]; then
            continue
        fi
        filename=`echo $line | awk -F/ '{print $NF}'`
        if echo "$filename" | grep -q "bulk"; then
            pv $filename | tar -I zstd -xf - -C $EXTRACT_DIR
        else
            pv $filename | tar -I zstd -xf - -C $EXTRACT_DIR --strip-components=3
        fi
    done < $compiled_files
}
echo "extracting files..."
# execute final data extraction step
extract_files $client-$network-incremental-compiled-files.txt

# move files
#rm -rf /data/polygon/bor-home/bor/chaindata
#mv /data/polygon/bor-home/snap /data/polygon/bor-home/bor/chaindata
