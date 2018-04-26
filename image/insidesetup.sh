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

RUN createfakepkg gamin && dpkg -i gamin.deb && rm gamin.deb
RUN createfakepkg libgamin0 && dpkg -i libgamin0.deb && rm libgamin0.deb

cd /tmp

apt-get download libgamin0:amd64
dpkg -x libgamin0*amd64.deb libgamin-amd64
mv libgamin-amd64/usr/lib/* /usr/lib/x86_64-linux-gnu/
rm -r libgamin*

apt-get download libgamin0:armhf
dpkg -x libgamin0*armhf.deb libgamin-armhf
mv libgamin-armhf/usr/lib/* /usr/lib/arm-linux-gnueabihf/
rm -r libgamin*

apt-get install libkf5config-bin-dev:amd64 \
    libkf5config-bin-dev:armhf \
    libkf5coreaddons-dev:amd64 \
    libkf5coreaddons-dev-bin:amd64 \
    libkf5coreaddons-dev:armhf \
    kirigami2-dev:armhf \
    phonon4qt5-backend-gstreamer:armhf \
    qtdeclarative5-dev:armhf -y

apt-get -a armhf build-dep kirigami -y
