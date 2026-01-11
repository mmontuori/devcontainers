#!/bin/bash
# CATALOG_DESCRIPTION: A script to install witr (Why Is This Running) command line tool
# Script to install witr command line tool
# form https://github.com/pranshuparmar/witr

TMP_DIR=$(mktemp -d)
ARCH=$(dpkg --print-architecture)
if [ "$ARCH" == "" ]; then
    echo "Could not determine architecture"
    exit 1
fi
LATEST_VERSION=$(curl --silent https://api.github.com/repos/pranshuparmar/witr/releases/latest | jq ".tag_name" | sed s/\"//g)
DEST_DIR="/usr/local/bin"

function usage
{
    echo "usage: `basename $0` [-f]"
    echo "    -f = force install even if witr is already installed"
}

while getopts "f" opt; do
	case $opt in
		f)
			force="true"
			;;
		*)
			usage
			exit
			;;
	esac
done

if test -f ${DEST_DIR}/witr && [ "$force" != "true" ]; then
    echo "witr is already installed in ${DEST_DIR}/witr"
    echo "Use -f option to force re-install"
    exit
fi

echo "Downloading witr for ${ARCH}, version ${LATEST_VERSION} to $TMP_DIR..."

cd $TMP_DIR

wget --no-check-certificate https://github.com/pranshuparmar/witr/releases/download/${LATEST_VERSION}/witr-linux-${ARCH} --quiet --output-document=${TMP_DIR}/witr

chmod 755 ${TMP_DIR}/witr
echo "Installing witr to ${DEST_DIR}/witr..."
sudo chown root:root ${TMP_DIR}/witr

sudo mv ${TMP_DIR}/witr ${DEST_DIR}/witr
rmdir ${TMP_DIR}
