#!/bin/bash
# Installs the specified version of git from sources into /usr/local
# for the latest release version please see:
# https://github.com/git/git/releases
export VER="2.23.0"
wget https://github.com/git/git/archive/v${VER}.tar.gz
tar -xvf v${VER}.tar.gz
rm -f v${VER}.tar.gz
cd git-*
make configure
./configure --prefix=/usr/local
sudo make install
