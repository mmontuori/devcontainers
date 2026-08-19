#!/bin/bash

source "$(dirname "$0")/setenv.sh"

echo "using container runtime: $container_runtime"

if [ "$1" == "" ]; then
    echo "usage: push {image_name} [remote_image_name]"
    echo ""
    echo "choose one of the following container files to build:"
    echo ""
    ls -C "${running_dir}/containerfiles/" | sed 's/  /\n/g'
    exit
fi

image_name="${1}"

if [ "$2" == "" ]; then
    remote_name="${image_name}"
else
    remote_name="${2}"
fi

echo "pushing container image ${image_name} to ${image_server}/${remote_name}"

${container_runtime} tag ${1} images.pkgrepo.bcbssc.com/${remote_name}
${container_runtime} push images.pkgrepo.bcbssc.com/${remote_name}
${container_runtime} tag images.pkgrepo.bcbssc.com/${remote_name} ${1}
