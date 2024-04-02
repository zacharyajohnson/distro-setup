#!/bin/sh

(
        cd '/tmp' || exit

        version='23.12.1'
        file_name="anki-$version-linux-qt6"
        zipped_file_name="$file_name.tar.zst"

        curl -OL "https://github.com/ankitects/anki/releases/download/$version/$zipped_file_name"
        tar --use-compress-program=unzstd -xvf "$zipped_file_name"


        cd "$file_name" || exit
        sudo ./install.sh
)
