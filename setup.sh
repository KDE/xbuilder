#!/bin/bash

CHROOT_PATH=`pwd`/plasma-mobile-sdk
XBUILDER_DIR=$(readlink -f $(dirname -- "$0"))

set -e
./chreatechroot $XBUILDER_DIR

sed -e "s#@CHROOT_PATH@#$CHROOT_PATH#" \
    -e "s#@SRC_PATH@#$1#" \
    -e "s#@SHELL@#$SHELL#" \
    $XBUILDER_DIR/go-mobile.in > $XBUILDER_DIR/go-mobile

chmod a+x $XBUILDER_DIR/go-mobile

mount |grep $CHROOT_PATH/sys 2>&1 >> /dev/null || mount --bind /sys $CHROOT_PATH/sys
mount |grep $CHROOT_PATH/dev 2>&1 >> /dev/null || mount --bind /dev $CHROOT_PATH/dev
mount |grep $CHROOT_PATH/proc 2>&1 >> /dev/null || mount --bind /proc $CHROOT_PATH/proc

# Note: This script may fail in the end, since it installs cross-compile dependencies
# which are often broken, so run this last
chroot $CHROOT_PATH /root/insidesetup.sh

sudo umount $CHROOT_PATH/sys
sudo umount $CHROOT_PATH/dev
sudo umount $CHROOT_PATH/proc

sudo mkdir -p $CHROOT_PATH/home/plasmamobile/src
