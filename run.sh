#!/bin/bash

source "$(dirname "$0")/setenv.sh"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    find "${running_dir}/containerfiles/" -maxdepth 1 -type f -printf "%f\n"
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
    cmd="su - ${container_user}"
    #cmd="/bin/zsh -i"
fi

#if [ "$1" == "aienv" ]; then
#    export container_port=8888
#fi

if [ "$container_user" == "root" ]; then
    user_string="root:root"
else
    user_string="${container_user}:devgroup"
fi

echo "running ${cmd} as starting command..."

if [ "$run_detached" == "true" ]; then
    run_args="--detach"
else
    run_args=""
fi

cd ${running_dir}

$container_runtime run ${run_args} --name $container_name --hostname $container_name --security-opt label=disable --rm --user ${user_string} ${gpu_args} $container_args -w /home/${container_user} -v ${dev_volume}:/home/${container_user} -ti ${label}/$1 ${cmd}
