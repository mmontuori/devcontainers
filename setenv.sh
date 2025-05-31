#!/bin/bash

. .env


if [ "$label" == "" ]; then
    export label="mmontuori"
fi

if [ "$container_runtime" == "" ]; then
    export container_runtime="podman"
fi

if [ "$container_user" == "" ]; then
    export container_user="devuser"
fi

if [ "$container_port" != "" ]; then
    export container_args="-p${container_port}:${container_port}"
fi

if [ "$use_gpus" != "" ]; then
    export gpu_args="--gpus=all"
fi

if [ "$dev_volume" == "" ]; then
    export dev_volume="devvol"
fi

if [ "$1" == "print" ]; then
    echo "use_gpus=${use_gpus}"
    echo "container_runtime=${container_runtime}"
    echo "label=${label}"
    echo "container_user=${container_user}"
    echo "container_port=${container_port}"
    echo "dev_volume=${dev_volume}"
fi