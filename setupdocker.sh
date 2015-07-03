#!/bin/bash

set -e

CHROOT_PATH=`pwd`/plasma-mobile-sdk
XBUILDER_DIR=$(readlink -f $(dirname -- "$0"))

sudo ./createchroot.sh $XBUILDER_DIR

cd $CHROOT_PATH
sudo tar cpf - . | docker import - plasma-mobile-sdk
docker run -t -i --rm plasma-mobile-sdk /root/insidesetup.sh
