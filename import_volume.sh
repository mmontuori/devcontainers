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
    echo "The volume ${dev_volume} does not exist. Creating it..."
    $container_runtime volume create ${dev_volume}    
fi

cd ${1}/../
tar -cf ${dev_volume}.tar `basename ${1}`

$container_runtime volume import ${dev_volume} ${dev_volume}.tar
rm ${dev_volume}.tar
echo "Directory ${1} has been successfully imported to ${dev_volume}."