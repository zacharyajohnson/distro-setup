#!/bin/sh

export_folder="$HOME/.distro-config/export/git/"

mkdir -p "$export_folder"
cp 'export/export.sh' "$export_folder"
