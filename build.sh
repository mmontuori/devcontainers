#!/bin/bash

if ! test -f .env; then
    echo "No .env file found. Please create one with the necessary environment variables."
    exit 1
fi
source setenv.sh

echo "using container runtime: $container_runtime"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    find containerfiles/ -maxdepth 1 -type f -printf "%f\n"
    exit
fi

if $container_runtime build -t ${label}/$1 -f containerfiles/$1 .; then
	echo "y" | $container_runtime builder prune
    echo ""
	$container_runtime image prune -f --filter label=stage=build-step
fi
