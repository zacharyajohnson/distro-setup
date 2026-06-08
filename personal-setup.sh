#!/bin/sh

package=anki,asunder,calibre,cron,discord,firefox,git,jetbrains-toolbox,jq,keepassxc,kid3,lgog-downloader\
,mullvad,nautilus-dropbox,noto-fonts,nsxiv,openrgb,proprietary-nvidia-driver,psensor,qbittorrent\
,qdirstat,shellcheck,smartmontools,steam,tmux,unzip,vim,wine,xfce,xorg-server

"$(dirname "$0")"'/setup.sh' --package="$package" --prompt-for-install --native-and-non-native-packages
