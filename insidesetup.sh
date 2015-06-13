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

deb http://ppa.launchpad.net/kubuntu-ci/unstable/ubuntu vivid main
deb-src http://ppa.launchpad.net/kubuntu-ci/unstable/ubuntu vivid main" > /etc/apt/sources.list

apt update
apt-get install crossbuild-essential-armhf adduser dh-exec vim zsh git htop -y
apt-get build-dep -a armhf kwin -y --force-yes #--host-architecture=armhf # force-yes is needed because "WARNING: The packages cannot be authenticated!"

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A12B6139432062D1


adduser plasmamobile --gecos "" --disabled-password
mkdir -p /home/plasmamobile/src
su plasmamobile -c "git clone https://github.com/plasma-mobile/xutils.git /home/plasmamobile"

tee --append /home/plasmamobile/.zshrc /home/plasmamobile/.bashrc >/dev/null << EOF

export \`cat /etc/environment\`
unset LANG
CC=/usr/bin/arm-linux-gnueabihf-gcc
VARS=\`dpkg-architecture -A amd64 -a armhf -l\`
export \$VARS
export PATH=/home/plasmamobile/xutils:\$PATH
EOF

echo "plasmamobile   ALL=NOPASSWD:ALL" >> /etc/sudoers

