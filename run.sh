#!/bin/bash

if ! test -f .env; then
    echo "No .env file found. Please create one with the necessary environment variables."
    exit 1
fi
source setenv.sh

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    ls -C containerfiles/ | sed 's/  /\n/g'
    echo ""
    echo "set the following variables in the .env file:"
    echo "    export container_user="
    echo "    export container_port="
    echo "    export use_gpus="
    echo ""
    exit
fi

if [ "$2" != "" ];then
    cmd="${2} ${3} ${4} ${5} ${6}"
else
    cmd="/bin/bash"
fi

#if [ "$1" == "aienv" ]; then
#    export container_port=8888
#fi

echo "using container runtime: $container_runtime"
echo "container_user=${container_user}"
echo "container_port=${container_port}"
echo "use_gpus=${use_gpus}"

echo "running ${cmd} as starting command..."

$container_runtime run --security-opt label=disable --rm --user ${container_user}:devgroup ${gpu_args} $container_args -w /home/${USER} -v ${dev_volume}:/home/${USER} -ti ${label}/$1 ${cmd}
