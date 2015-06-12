CHROOT_PATH=`pwd`/testdir

if [ "$#" -ne 1 ]; then
    echo "usage: setup.sh <src-directory>"
    exit
fi

set -e
which debootstrap > /dev/null
which chroot > /dev/null

# debootstrap vivid $CHROOT_PATH http://archive.ubuntu.com/ubuntu
#
# mount |grep $CHROOT_PATH/sys 2>&1 >> /dev/null || mount --bind /sys $CHROOT_PATH/sys
# mount |grep $CHROOT_PATH/dev 2>&1 >> /dev/null || mount --bind /dev $CHROOT_PATH/dev
# mount |grep $CHROOT_PATH/proc 2>&1 >> /dev/null || mount --bind /proc $CHROOT_PATH/proc
#
# cp insidesetup.sh $CHROOT_PATH/root/
# chroot $CHROOT_PATH /root/insidesetup.sh

sed -e "s#@CHROOT_PATH@#$CHROOT_PATH#" -e "s#@SRC_PATH@#$1#" go-mobile.in > go-mobile
chmod a+x go-mobile

