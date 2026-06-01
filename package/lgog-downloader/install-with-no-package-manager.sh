#!/bin/sh
(
        cd '/tmp' || exit

        version='3.17'
        folder_name="lgogdownloader-$version"
        zip_name="lgogdownloader-$version.tar.gz"

        curl -OL "https://github.com/Sude-/lgogdownloader/releases/download/v$version/$zip_name"

        tar -xvf "$zip_name"

        cd "$folder_name" || exit

        sudo cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_QT_GUI=ON -GNinja
        sudo ninja -Cbuild install
)

