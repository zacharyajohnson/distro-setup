#!/bin/sh

(
        cd '/tmp' || exit

        version='25.09'
        file_name="anki-launcher-$version-linux"
        zipped_file_name="$file_name.tar.zst"

        curl -OL "https://github.com/ankitects/anki/releases/download/$version/$zipped_file_name"
        tar --use-compress-program=unzstd -xvf "$zipped_file_name"


        cd "$file_name" || exit
        sudo ./install.sh
)
