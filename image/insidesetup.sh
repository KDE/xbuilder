#! /bin/bash
set -e

unset LANG #remove? or just install locales...

source /etc/environment
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

deb [arch=armhf,amd64] http://mobile.neon.pangea.pub xenial main
deb-src [arch=armhf,amd64] http://mobile.neon.pangea.pub xenial main
" > /etc/apt/sources.list

echo 'Debug::pkgProblemResolver "true";' > /etc/apt/apt.conf.d/debug

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A12B6139432062D1

pushd /tmp
rm key || true
wget http://mobile.kci.pangea.pub/Pangea%20CI.gpg.key -O key
apt-key add key
popd

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
export QMAKESPEC=ubuntu-arm-gnueabihf-g++
EOF

apt-get build-dep -a armhf kwin -y --force-yes #--host-architecture=armhf # force-yes is needed because "WARNING: The packages cannot be authenticated!"
