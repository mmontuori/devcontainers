#!/bin/bash

source "$(dirname "$0")/setenv.sh"

echo "using container runtime: $container_runtime"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to init:"
    echo ""
    find "${running_dir}/containerfiles/" -maxdepth 1 -type f -printf "%f\n"
    exit
fi

docker_id=`$container_runtime ps | grep "$1" | awk '{ print $1 }'`

$container_runtime cp ~/.ssh ${docker_id}:/home/devuser/
