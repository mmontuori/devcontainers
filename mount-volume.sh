#!/bin/bash

if ! test -f .env; then
    echo "No .env file found. Please create one with the necessary environment variables."
    exit 1
fi
source setenv.sh

if [ "$1" == "" ]; then
    echo "choose one of the following volunes to mount on /mnt/volume:"
    echo ""
    docker volume ls
    echo ""
    exit
fi

volume="$1"

echo "using container runtime: $container_runtime"
echo "container_user=${container_user}"
echo "container_port=${container_port}"
echo "use_gpus=${use_gpus}"
echo "volume=${volume}"
echo "mount directory: /mnt/vol"

if [ "$container_user" == "root" ]; then
    user_string="root:root"
else
    user_string="${container_user}:devgroup"
fi

echo "running ${cmd} as starting command..."

$container_runtime run --security-opt label=disable --rm --user ${user_string} ${gpu_args} $container_args -v ${volume}://mnt/vol -ti ${label}/toolbox /bin/bash
