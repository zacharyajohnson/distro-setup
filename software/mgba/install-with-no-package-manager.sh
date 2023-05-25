#!/bin/sh

set -e

printf 'Installing dependency cmake\n'
sudo pacman -S cmake

git clone https://github.com/mgba-emu/mgba

cd mgba

mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
make
sudo make install

cd ../..

rm -rf mgba

