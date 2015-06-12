#! /bin/bash
set -e

unset LANG #remove? or just install locales...

source /etc/environment
dpkg --add-architecture armhf

echo "\
deb [arch=armhf] http://ports.ubuntu.com/ vivid main universe restricted
deb-src [arch=armhf]  http://ports.ubuntu.com/ vivid main universe restricted

deb [arch=armhf] http://ports.ubuntu.com/ vivid-updates main universe restricted
deb-src [arch=armhf] http://ports.ubuntu.com/ vivid-updates main universe restricted

deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu vivid main universe restricted
deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu vivid main universe restricted

deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu vivid-updates main universe restricted
deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu vivid-updates main universe restricted

deb http://ppa.launchpad.net/kubuntu-ci/unstable/ubuntu vivid main" > /etc/apt/sources.list

apt update
apt-get install crossbuild-essential-armhf adduser dh-exec vim zsh git -y
apt-get build-dep -a armhf kwin -y --force-yes #--host-architecture=armhf # force-yes is needed because "WARNING: The packages cannot be authenticated!"

adduser plasmamobile --gecos "" --disabled-password
mkdir -p /home/plasmamobile/src

RC="
export \`cat /etc/environment\`
unset LANG
CC=/usr/bin/arm-linux-gnueabihf-gcc
VARS=\`dpkg-architecture -A amd64 -a armhf -l\`
export \$VARS"
echo $RC >> /home/plasmamobile/.bashrc
echo $RC >> /home/plasmamobile/.zshrc

echo "plasmamobile   ALL=NOPASSWD:ALL" >> /etc/sudoers

