#!/bin/sh

set -e

if [ "$OS" == "debian" ]; then
    #MIRRORSITE="http://ftp.no.debian.org/debian/"
    MIRRORSITE="http://kambing.ui.ac.id/debian/"
    COMPONENTS="main contrib non-free"
    DEBOOTSTRAPOPTS=("${DEBOOTSTRAPOPTS[@]}"
        "--keyring=/usr/share/keyrings/debian-archive-keyring.gpg")
    : ${DIST:="jessie"}
    : ${ARCH:="amd64"}
    if [ "$DIST" == "jessie" ]; then
        #EXTRAPACKAGES="$EXTRAPACKAGES debian-backports-keyring"
        OTHERMIRROR="$OTHERMIRROR | deb $MIRRORSITE jessie-backports $COMPONENTS"
    fi
elif [ "$OS" == "raspbian" ]; then
    MIRRORSITE="http://ftp.acc.umu.se/mirror/raspbian/raspbian/"
    COMPONENTS="main contrib non-free"
    DEBOOTSTRAPOPTS=("${DEBOOTSTRAPOPTS[@]}"
        "--keyring=/usr/share/keyrings/raspbian-archive-keyring.gpg")
    : ${DIST:="jessie"}
    : ${ARCH:="armhf"}
elif [ "$OS" == "blankon" ]; then
    MIRRORSITE="http://arsip.blankonlinux.or.id/blankon/"
    COMPONENTS="main restricted extras extras-restricted"
    DEBOOTSTRAPOPTS=("${DEBOOTSTRAPOPTS[@]}"
        "--keyring=/usr/share/keyrings/blankon-archive-keyring.gpg")
    : ${DIST:="tambora"}
    : ${ARCH:="amd64"}
elif [ "$OS" == "ubuntu" ]; then
    MIRRORSITE="http://no.archive.ubuntu.com/ubuntu/"
    COMPONENTS="main restricted universe multiverse"
    DEBOOTSTRAPOPTS=("${DEBOOTSTRAPOPTS[@]}"
        "--keyring=/usr/share/keyrings/ubuntu-archive-keyring.gpg")
else
    echo "Unknown OS: $OS"
    exit 1
fi

if [ "$DIST" == "" ]; then
    echo "DIST is not set"
    exit 1
fi

if [ "$ARCH" == "" ]; then
    echo "ARCH is not set"
    exit 1
fi

NAME="$OS-$DIST-$ARCH"

if [ "$ARCH" == "armel" ] && [ "$(dpkg --print-architecture)" != "armel" ]; then
    DEBOOTSTRAP="qemu-debootstrap"
fi
if [ "$ARCH" == "armhf" ] && [ "$(dpkg --print-architecture)" != "armhf" ]; then
    DEBOOTSTRAP="qemu-debootstrap"
fi

DEBOOTSTRAPOPTS=("${DEBOOTSTRAPOPTS[@]}" "--arch=$ARCH")
BASETGZ="/var/cache/pbuilder/$NAME-base.tgz"
DISTRIBUTION="$DIST"
BUILDRESULT="/var/cache/pbuilder/$NAME/result/"
APTCACHE="/var/cache/pbuilder/$NAME/aptcache/"
BUILDPLACE="/var/cache/pbuilder/build"
HOOKDIR="/var/cache/pbuilder/hook.d/"
