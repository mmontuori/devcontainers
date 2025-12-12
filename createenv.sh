#!/bin/bash

ENV_FILE=".env"

if test -f $ENV_FILE; then
        echo "environment file already exists! Remove manually before running this script"
        exit 1
fi

read -p "container runtime [podman|docker]: " container_runtime

if [ "$container_runtime" != "podman" ] && [ "$container_runtime" != "docker" ]; then
	echo "only 'docker' and 'podman' are supported container runtimes"
	exit 1
fi

read -p "default container user: " container_user
read -p "default container port: " container_port
read -p "container dev volume [default=devvol]: " container_devvol
read -p "use GPUs [true|yes] (leave empty if not needed): " container_use_gpus
read -p "container label [default=mmontuori]: " container_label

echo "export container_runtime=\"$container_runtime\"" > $ENV_FILE
if [ "$container_label" != '' ]; then
	echo "export label=\"$container_label\"" >> $ENV_FILE
fi
if [ "$container_user" != '' ]; then
	echo "export container_user=\"$container_user\"" >> $ENV_FILE
fi
if [ "$container_port" != '' ]; then
	echo "export container_port=\"$container_port\"" >> $ENV_FILE
fi
if [ "$container_devvol" != '' ]; then
	echo "export dev_volume=\"$container_devvol\"" >> $ENV_FILE
fi
