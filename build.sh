#!/bin/bash

source "$(dirname "$0")/setenv.sh"

echo "using container runtime: $container_runtime"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    find "${running_dir}/containerfiles/" -maxdepth 1 -type f -printf "%f\n"
    exit
fi

cd ${running_dir}

if $container_runtime build -t ${label}/$1 -f containerfiles/$1 .; then
	echo "y" | $container_runtime builder prune
    echo ""
	$container_runtime image prune -f --filter label=stage=build-step
fi
