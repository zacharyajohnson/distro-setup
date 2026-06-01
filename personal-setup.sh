#!/bin/sh

software=anki,asunder,calibre,cron,discord,firefox,git,intellij,keepassxc,kid3,lgog-downloader\
,mullvad,nautilus-dropbox,nsxiv,openrgb,proprietary-nvidia-driver,psensor,qbittorrent\
,qdirstat,shellcheck,smartmontools,steam,tmux,vim,wine,xfce,xorg-server

"$(dirname "$0")"'/setup.sh' --software="$software" --prompt-for-install --native-and-non-native-packages
