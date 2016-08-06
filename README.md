# pbuilder

## Membangun paket Debian ARM dengan pbuilder

Script ini digunakan untuk memudahkan proses membangun paket Debian secara
otomatis di dalam lingkungan yang bersih, bersih dari "kotoran" pustaka atau dependensi program
yang tidak seharusnya. dapat dengan lancar jaya dipasang dan dibangun pada sistem Debian lain
misal akan diunggah ke pabrik paket BlankOn, Raspbian dll.

### Cara Pemakaian

Unduh script `pbuilderrc.sh`:

    $ wget https://raw.githubusercontent.com/debian-id/pbuilder/master/pbuilderrc.sh
    $ cp pbuilderrc.sh .pbuilderrc
    
Unduh paket keyring dari masing-masing distribusi:

**Debian**

Apabila Anda menggunakan Debian:

    $ sudo apt-get install -y debian-archive-keyring
    
Kemudian unduh dan pasang paket keyring lainnya secara manual:

    $ wget http://no.archive.ubuntu.com/ubuntu/pool/main/u/ubuntu-keyring/ubuntu-keyring_2016.05.13_all.deb
    $ sudo dpkg -i ubuntu-keyring_2016.05.13_all.deb

    $ wget http://archive.raspbian.org/raspbian/pool/main/r/raspbian-archive-keyring/raspbian-archive-keyring_20120528.2_all.deb
    $ sudo dpkg -i raspbian-archive-keyring_20120528.2_all.deb

    $ wget http://arsip.blankonlinux.or.id/blankon/pool/main/b/blankon-keyring/blankon-keyring_2016.06.16-4_all.deb
    $ sudo dpkg -i blankon-keyring_2016.06.16-4_all.deb
    
**Ubuntu**

Apabila Anda menggunakan Ubuntu:

    $ sudo apt-get install -y ubuntu-keyring debian-archive-keyring

Lakukan seperti langkah pada Debian namun, lompati paket `ubuntu-keyring`.

**Raspbian**

Apabila Anda menggunakan Raspbian:

    $ sudo apt-get install -y raspbian-archive-keyring debian-archive-keyring

Lakukan seperti langkah pada Debian namun, lompati paket `raspbian-archive-keyring`.

**Blankon**

Apabila Anda menggunakan Blankon:

    $ sudo apt-get install -y blankon-keyring debian-archive-keyring

Lakukan seperti langkah pada Debian namun, lompati paket `blankon-keyring`.

Periksa hasilnya:

    $ ls /usr/share/keyrings

    $ sudo OS=debian DIST=jessie ARCH=amd64 pbuilder --create
    $ sudo OS=debian DIST=jessie ARCH=i386 pbuilder --create
    $ sudo OS=debian DIST=jessie ARCH=armel pbuilder --create
    $ sudo OS=raspbian DIST=jessie ARCH=armhf pbuilder --create
    $ sudo OS=debian DIST=jessie ARCH=armhf pbuilder --create

Hasilnya:

    $ ls /var/cache/pbuilder

    $ OS=raspbian DIST=jessie ARCH=armhf pdebuild

