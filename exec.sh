#!/bin/bash

label="mmontuori"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    ls -C containerfiles/ | sed 's/  /\n/g'
    exit
fi

if [ "$2" != "" ];then
    cmd="${2} ${3} ${4} ${5} ${6}"
else
    cmd="/bin/bash"
fi
echo "running ${cmd} as starting command..."

docker_id=`docker ps | grep "$1" | awk '{ print $1 }'`

docker exec -ti ${docker_id} ${cmd}
