#!/bin/sh


export_folder="$HOME/.export/dropbox/"

if [ -n "$CLOUD_FOLDER" ]; then
        printf 'Cloud folder is set to %s. Would you like to override? (Y)es/(N)o\n' "$CLOUD_FOLDER" 
        read -r answer

        if [ "$answer" = 'n' ] || [ "$answer" = 'N' ]; then
                printf 'Aborting export installation...\n'
                exit
        fi
fi


mkdir -p "$export_folder"
cp 'export/export.sh' "$export_folder"
