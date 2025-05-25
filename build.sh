#!/bin/bash

if ! test -f .env; then
    echo "No .env file found. Please create one with the necessary environment variables."
    exit 1
fi
source .env

echo "using container runtime: $container_runtime"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    ls -C containerfiles/ | sed 's/  /\n/g'
    exit
fi

if $container_runtime build -t ${label}/$1 -f containerfiles/$1 .; then
	echo "y" | $container_runtime builder prune
	$container_runtime image prune -f --filter label=stage=build-step
fi
