FROM ubuntu:xenial

LABEL Description="Plasma Mobile SDK"
MAINTAINER Aleix Pol i Gonzalez <aleixpol@kde.org>

COPY insidesetup.sh /root/insidesetup.sh
COPY sources.list /etc/apt/sources.list
COPY apt-debug /etc/apt/apt.conf.d/debug

RUN dpkg --add-architecture armhf

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 444DABCF3667D0283F894EDDE6D4736255751E5D
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E47F5011FA60FC1DEBB1998933056FA14AD3A421

RUN apt update
RUN apt install crossbuild-essential-armhf adduser dh-exec vim zsh git htop python sudo cmake-curses-gui -y
RUN adduser plasmamobile --gecos "" --disabled-password

RUN bash /root/insidesetup.sh
