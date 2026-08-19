#!/bin/bash

source "$(dirname "$0")/setenv.sh"

echo "using container runtime: $container_runtime"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to exec:"
    echo ""
    find "${running_dir}/containerfiles/" -maxdepth 1 -type f -printf "%f\n"
    exit
fi

if [ "$2" != "" ];then
    cmd="${2} ${3} ${4} ${5} ${6}"
else
    cmd="su - ${container_user}"
fi
echo "running ${cmd} as starting command..."

docker_id=`$container_runtime ps | grep "$1" | awk '{ print $1 }'`

cd ${running_dir}

$container_runtime exec -ti ${docker_id} ${cmd}
