#!/bin/sh

debian_version='Debian_11'
arch='amd64'
url="https://mega.nz/linux/repo/$debian_version/$arch"

mega_sync_file_name="megasync-"$debian_version"_"$arch".deb"
mega_cmd_file_name="megacmd-"$debian_version"_"$arch".deb"

printf 'Installing megasync...\n\n'
curl -O "$url/$mega_sync_file_name"

sudo apt-get install -f "./$mega_sync_file_name"

rm "$mega_sync_file_name"

printf 'Installing megacmd...\n\n'
curl -O "$url/$mega_cmd_file_name"

sudo apt-get install -f "./$mega_cmd_file_name"

rm "$mega_cmd_file_name"
