#!/bin/sh

export_dir="$HOME/.distro-config/bin"
mkdir -p "$export_dir"

cp -r bin/. "$export_dir"
