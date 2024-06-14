#!/bin/bash

if [ "$1" == "" ]; then
    echo "choose one of the following container files to build:"
    echo ""
    ls -C containerfiles/ | sed 's/  /\n/g'
    exit
fi

container_user="devuser"

if [ "$2" != "" ];then
    cmd="${2} ${3} ${4} ${5} ${6}"
else
    cmd="/bin/bash"
fi
echo "running ${cmd} as starting command..."

docker run --rm --user ${container_user}:devgroup -w /home/${USER} -v ${HOME}:/home/${USER} --rm -ti $1 ${cmd}
