#!/bin/sh

(
        cd '/tmp' || exit

        git clone https://github.com/mgba-emu/mgba

        cd mgba

        mkdir build
        cd build

        cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
        make
        sudo make install
)
