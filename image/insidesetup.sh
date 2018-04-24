#! /bin/bash
set -e

unset LANG #remove? or just install locales...

source /etc/environment

apt update

apt-get install wget -y

dpkg --add-architecture armhf

echo "deb [arch=armhf] http://ports.ubuntu.com/ xenial main universe restricted
deb-src [arch=armhf]  http://ports.ubuntu.com/ xenial main universe restricted

deb [arch=armhf] http://ports.ubuntu.com/ xenial-updates main universe restricted
deb-src [arch=armhf] http://ports.ubuntu.com/ xenial-updates main universe restricted

deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu xenial main universe restricted
deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu xenial main universe restricted

deb [arch=i386,amd64] http://archive.ubuntu.com/ubuntu xenial-updates main universe restricted
deb-src [arch=i386,amd64] http://archive.ubuntu.com/ubuntu xenial-updates main universe restricted

deb [arch=armhf,amd64] http://archive.neon.kde.org/dev/unstable xenial main
deb-src [arch=armhf,amd64] http://archive.neon.kde.org/dev/unstable xenial main
" > /etc/apt/sources.list

echo 'Debug::pkgProblemResolver "true";' > /etc/apt/apt.conf.d/debug

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 444DABCF3667D0283F894EDDE6D4736255751E5D 
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E47F5011FA60FC1DEBB1998933056FA14AD3A421

apt update
apt-get install crossbuild-essential-armhf adduser dh-exec vim zsh git htop python sudo cmake-curses-gui -y


adduser plasmamobile --gecos "" --disabled-password
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
