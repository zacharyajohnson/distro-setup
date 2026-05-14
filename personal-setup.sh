#!/bin/sh

software=anki,asunder,cron,discord,git,intellij,keepassxc,kid3,lgog-downloader\
,nautilus-dropbox,proprietary-nvidia-driver,psensor,qbittorrent\
,qdirstat,shellcheck,steam,tmux,vim,wine,xfce

"$(dirname "$0")"'/setup.sh' --software="$software" --prompt-for-install --native-and-non-native-packages
