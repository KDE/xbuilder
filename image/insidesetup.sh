#! /bin/bash
set -e

unset LANG #remove? or just install locales...

source /etc/environment

su - plasmamobile -c "git clone git://anongit.kde.org/xutils.git /home/plasmamobile/xutils"
echo "plasmamobile   ALL=NOPASSWD:ALL" >> /etc/sudoers

cat << EOF > /home/plasmamobile/.gitconfig
[url "git://anongit.kde.org/"]
   insteadOf = kde:
[url "ssh://git@git.kde.org/"]
   pushInsteadOf = kde:
EOF

tee --append /home/plasmamobile/.zshrc /home/plasmamobile/.bashrc >/dev/null << EOF

export \`cat /etc/environment\`
unset LANG
CC=/usr/bin/arm-linux-gnueabihf-gcc
VARS=\`dpkg-architecture -A amd64 -a armhf -l\`
export \$VARS
export PATH=/home/plasmamobile/xutils:\$PATH
EOF

/home/plasmamobile/xutils/createfakepkg gamin && dpkg -i gamin.deb && rm /gamin.deb
/home/plasmamobile/xutils/createfakepkg libgamin0 && dpkg -i libgamin0.deb && rm /libgamin0.deb

apt-get install libkf5config-bin-dev:amd64 libkf5config-bin-dev:armhf libkf5coreaddons-dev:amd64 libkf5coreaddons-dev-bin:amd64 libkf5coreaddons-dev:armhf kirigami2-dev:armhf phonon4qt5-backend-gstreamer:armhf qtdeclarative5-dev:armhf -y
apt-get -a armhf build-dep kirigami -y
