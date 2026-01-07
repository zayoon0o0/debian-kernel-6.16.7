#!/bin/bash

VERSION="6.18.3"

ROOT="$PWD"
TARBALL="linux-6.18.3.tar.xz"
TARBALLURL="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.18.3.tar.xz"

curl -LO $TARBALLURL
tar -xf $TARBALL
cd linux-6.18.3

for patch in $(ls $ROOT/patches)
do
	patch -p1 < $ROOT/patches/$patch
done

cp ${ROOT}/config .config
make olddefconfig
make bindeb-pkg -j$(nproc) INSTALL_MOD_STRIP=1
