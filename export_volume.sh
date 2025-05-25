#!/bin/bash

if ! test -f .env; then
    echo "No .env file found. Please create one with the necessary environment variables."
    exit 1
fi
source .env

if [ "$1" == "" ]; then
    echo "Usage: $0 <local_path>"
    exit 1
fi

if ! test -d "$1"; then
    echo "ERROR: The local path $1 does not exist. Please create it first."
    exit 1
fi

if ! $container_runtime volume inspect ${dev_volume} > /dev/null 2>&1; then
    echo "ERROR: The volume ${dev_volume} does not exist. Please create it first."
    exit 1
fi

$container_runtime volume export ${dev_volume} --output ${1}/${dev_volume}.tar
cd ${1}
tar -xf ${dev_volume}.tar
rm ${dev_volume}.tar
echo "Volume ${dev_volume} has been successfully exported to ${1}."