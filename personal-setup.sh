#!/bin/sh

software=anki,asunder,bluez,bluez-utils,cron,discord,flatpak,git,intellij,keepassxc,kid3,lgog-downloader\
,mgba,nautilus-dropbox,proprietary-nvidia-driver,psensor,qbittorrent\
,qdirstat,rustlang,shellcheck,steam,tmux,vim,wine,xfce

"$(dirname "$0")"'/setup.sh' --software="$software" --prompt-for-install --native-and-non-native-packages
