#!/bin/sh

destination_folder='/opt/discord'
binary_file_name='Discord'
symlink_path='/usr/bin/discord'

version='0.0.39'
tar_name="discord-$version.tar.gz"
unzipped_folder_name='Discord'

# Do this for a clean install each time
if [ -d "$destination_folder" ]; then
        sudo rm -ir "$destination_folder"
fi

sudo mkdir -p "$destination_folder"

curl -O "https://dl.discordapp.net/apps/linux/$version/$tar_name"

tar -xvf "$tar_name"

sudo mv "$unzipped_folder_name"/* "$destination_folder"

sudo ln -sf "$destination_folder/$binary_file_name" "$symlink_path"

rm -i "$tar_name"
rm -i "$unzipped_folder_name"
