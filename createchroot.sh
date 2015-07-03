#!/bin/bash

set -e

CHROOT_PATH=`pwd`/plasma-mobile-sdk
XBUILDER_DIR=$1

which debootstrap > /dev/null
which chroot > /dev/null

debootstrap vivid $CHROOT_PATH http://archive.ubuntu.com/ubuntu

# Copy insidesetup.sh to root dir, we need the readlink magic here since insidesetup.sh
# may not be in the current directory
cp $XBUILDER_DIR/insidesetup.sh $CHROOT_PATH/root/
cp -R $XBUILDER_DIR/.zsh* $CHROOT_PATH/etc/skel
