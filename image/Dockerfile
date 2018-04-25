FROM ubuntu:xenial

LABEL Description="Plasma Mobile SDK"
MAINTAINER Aleix Pol i Gonzalez <aleixpol@kde.org>

COPY insidesetup.sh /root/insidesetup.sh
COPY sources.list /etc/apt/sources.list
COPY apt-debug /etc/apt/apt.conf.d/debug
COPY createfakepkg /usr/local/bin/createfakepkg
COPY gitconfig /etc/skel/.gitconfig

RUN dpkg --add-architecture armhf

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 444DABCF3667D0283F894EDDE6D4736255751E5D
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E47F5011FA60FC1DEBB1998933056FA14AD3A421

RUN apt update
RUN apt install crossbuild-essential-armhf adduser dh-exec vim zsh git htop python sudo cmake-curses-gui -y

RUN createfakepkg gamin && dpkg -i gamin.deb && rm gamin.deb
RUN createfakepkg libgamin0 && dpkg -i libgamin0.deb && rm libgamin0.deb

RUN adduser plasmamobile --gecos "" --disabled-password

RUN echo "plasmamobile   ALL=NOPASSWD:ALL" >> /etc/sudoers

RUN bash /root/insidesetup.sh
