#! /bin/bash
set -e

unset LANG #remove? or just install locales...

source /etc/environment

tee --append /home/plasmamobile/.zshrc /home/plasmamobile/.bashrc >/dev/null << EOF

export \`cat /etc/environment\`
CC=/usr/bin/arm-linux-gnueabihf-gcc
VARS=\`dpkg-architecture -A amd64 -a armhf -l\`
export \$VARS
export PATH=/home/plasmamobile/xutils:\$PATH
EOF

apt-get install libkf5config-bin-dev:amd64 libkf5config-bin-dev:armhf libkf5coreaddons-dev:amd64 libkf5coreaddons-dev-bin:amd64 libkf5coreaddons-dev:armhf kirigami2-dev:armhf phonon4qt5-backend-gstreamer:armhf qtdeclarative5-dev:armhf -y
apt-get -a armhf build-dep kirigami -y
