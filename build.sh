#!/bin/bash

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    ls -C containerfiles/ | sed 's/  /\n/g'
    exit
fi

if docker build -t $1 -f containerfiles/$1 .; then
	echo "y" | docker builder prune -a
fi
