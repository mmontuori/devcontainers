#!/bin/bash

label="mmontuori"

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    ls -C containerfiles/ | sed 's/  /\n/g'
    exit
fi

if docker build -t ${label}/$1 -f containerfiles/$1 .; then
	echo "y" | docker builder prune -a
	docker image prune -f --filter label=stage=build-step
fi
