#!/bin/bash

label="mmontuori"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    ls -C containerfiles/ | sed 's/  /\n/g'
    exit
fi

if [ "$container_user" == "" ]; then
    container_user="devuser"
fi

if [ "$2" != "" ];then
    cmd="${2} ${3} ${4} ${5} ${6}"
else
    cmd="/bin/bash"
fi

if [ "$1" == "aienv" ]; then
    export container_port=8888
fi

if [ "$container_port" != "" ]; then
    container_args="-p${container_port}:${container_port}"
fi

echo "container_user=${container_user}"
echo "container_port=${container_port}"

echo "running ${cmd} as starting command..."

docker run --rm --user ${container_user}:devgroup $container_args -w /home/${USER} -v ${HOME}:/home/${USER} --rm -ti ${label}/$1 ${cmd}
