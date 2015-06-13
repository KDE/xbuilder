#!/bin/bash

CHROOT_PATH=`pwd`/plasma-mobile-sdk

if [ "$#" -ne 1 ]; then
    echo "usage: setup.sh <src-directory>"
    exit
fi

set -e
which debootstrap > /dev/null
which chroot > /dev/null

debootstrap vivid $CHROOT_PATH http://archive.ubuntu.com/ubuntu

mount |grep $CHROOT_PATH/sys 2>&1 >> /dev/null || mount --bind /sys $CHROOT_PATH/sys
mount |grep $CHROOT_PATH/dev 2>&1 >> /dev/null || mount --bind /dev $CHROOT_PATH/dev
mount |grep $CHROOT_PATH/proc 2>&1 >> /dev/null || mount --bind /proc $CHROOT_PATH/proc

# Copy insidesetup.sh to root dir, we need the readlink magic here since insidesetup.sh
# may not be in the current directory
XBUILDER_DIR=$(readlink -f $(dirname -- "$0"))


cp $XBUILDER_DIR/insidesetup.sh $CHROOT_PATH/root/
cp -R $XBUILDER_DIR/.zsh* $CHROOT_PATH/etc/skel

sed -e "s#@CHROOT_PATH@#$CHROOT_PATH#" \
    -e "s#@SRC_PATH@#$1#" \
    -e "s#@SHELL@#$SHELL#" \
    $XBUILDER_DIR/go-mobile.in > $XBUILDER_DIR/go-mobile

chmod a+x $XBUILDER_DIR/go-mobile

# Note: This script may fail in the end, since it installs cross-compile dependencies
# which are often broken, so run this last
chroot $CHROOT_PATH /root/insidesetup.sh
