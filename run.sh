#!/bin/bash

if ! test -f .env; then
    echo "No .env file found. Please create one with the necessary environment variables."
    exit 1
fi
source setenv.sh

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    find containerfiles/ -maxdepth 1 -type f -printf "%f\n"
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
    #cmd="su - ${container_user}"
    cmd="/bin/bash -i"
fi

#if [ "$1" == "aienv" ]; then
#    export container_port=8888
#fi

echo "using container runtime: $container_runtime"
echo "container_user=${container_user}"
echo "container_port=${container_port}"
echo "use_gpus=${use_gpus}"

if [ "$container_user" == "root" ]; then
    user_string="root:root"
else
    user_string="${container_user}:devgroup"
fi

echo "running ${cmd} as starting command..."

$container_runtime run --security-opt label=disable --rm --user ${user_string} ${gpu_args} $container_args -w /home/${container_user} -v ${dev_volume}:/home/${container_user} -ti ${label}/$1 ${cmd}
