# pbuilder

## Membangun paket Debian ARM dengan pbuilder

Script ini digunakan untuk memudahkan proses membangun paket Debian secara
otomatis di dalam lingkungan yang bersih, bersih dari "kotoran" pustaka atau dependensi program
yang tidak seharusnya. dapat dengan lancar jaya dipasang dan dibangun pada sistem Debian lain
misal akan diunggah ke pabrik paket BlankOn, Raspbian dll.

### Cara Pemakaian

Unduh script `pbuilderrc.sh`:

    $ wget https://raw.githubusercontent.com/debian-id/pbuilder/master/pbuilderrc.sh
    $ sudo cp pbuilderrc.sh /root/.pbuilderrc
    
**Tips**

Untuk memperbaharui versi Debian pada script `pbuilderrc`:

    $ sudo sed -i 's/jessie/stretch/g /root/.pbuilderrc'

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

**BlankOn**

Apabila Anda menggunakan BlanOn:

    $ sudo apt-get install -y blankon-keyring debian-archive-keyring

Lakukan seperti langkah pada Debian namun, lompati paket `blankon-keyring`.

Periksa hasilnya:

    $ ls /usr/share/keyrings

Sebelum menjalankan pbuilder, kita harus menginstal paket `pbuilder` dan `qemu-debootstrap`:

    $ sudo apt-get install pbuilder qemu-user-static

Unduh terlebih dahulu berkas `debootstrap` BlankOn dan pindahkan ke
direktori `/usr/share/debootstrap/scripts`, apabila Anda menggunakan distro selain BlankOn:

    $ wget http://dev.blankon.id/export/current%3A/tambora/debootstrap/scripts/ombilin
    $ wget http://dev.blankon.id/export/current%3A/tambora/debootstrap/scripts/lontara
    $ sudo mv ombilin /usr/share/debootstrap/scripts
    $ sudo mv lontara /usr/share/debootstrap/scripts

Buat simbolik link untuk masing-masing rilis BlankOn:

    $ cd /usr/share/debootstrap/scripts
    $ sudo ln -s ombilin rote
    $ sudo ln -s ombilin pattimura
    $ sudo ln -s rote suroboyo
    $ sudo ln -s lontara nanggar
    $ sudo ln -s lontara meuligoe

Bila ingin menambahkan rilis Ubuntu `wily`, `xenial` dan `yakkety` apabila Anda
menggunakan Debian `jessie`, maka buat simbolik link untuk masing-masing rilis:

    $ cd /usr/share/debootstrap/scripts
    $ sudo ln -s gutsy wily
    $ sudo ln -s gutsy xenial
    $ sudo ln -s gutsy yakkety

Pilih salah satu dari pilihan berikut ini:

    $ sudo OS=debian DIST=jessie ARCH=amd64 pbuilder --create
    $ sudo OS=debian DIST=jessie ARCH=i386 pbuilder --create

    $ sudo OS=debian DIST=jessie ARCH=armel pbuilder --create
    $ sudo OS=debian DIST=jessie ARCH=armhf pbuilder --create

    $ sudo OS=raspbian DIST=jessie ARCH=armhf pbuilder --create
    $ sudo OS=ubuntu DIST=yakkety ARCH=amd64 pbuilder --create

    $ sudo OS=blankon DIST=suroboyo ARCH=amd64 pbuilder --create
    $ sudo OS=blankon DIST=tambora ARCH=amd64 pbuilder --create

Hasilnya dapat dilihat di:

    $ ls /var/cache/pbuilder

Sekarang kita siap untuk membangun paket. Pada dasarnya, Anda hanya perlu paket sumber dari paket Debian, masuk ke direktorinya, serta menjalankan:

    $ sudo OS=raspbian DIST=jessie ARCH=armhf pdebuild

Untuk melakukan pembaharuan, jalankan:

    $ sudo OS=raspbian DIST=jessie ARCH=armhf pbuilder --update
