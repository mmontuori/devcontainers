#!/bin/bash

if ! test -f .env; then
    echo "No .env file found. Please create one with the necessary environment variables."
    exit 1
fi
source setenv.sh

echo "using container runtime: $container_runtime"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    ls -C containerfiles/ | sed 's/  /\n/g'
    exit
fi

if [ "$2" != "" ];then
    cmd="${2} ${3} ${4} ${5} ${6}"
else
    cmd="su - ${container_user}"
fi
echo "running ${cmd} as starting command..."

docker_id=`$container_runtime ps | grep "$1" | awk '{ print $1 }'`

$container_runtime exec -ti ${docker_id} ${cmd}
