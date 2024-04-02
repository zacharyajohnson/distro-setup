#!/bin/sh

profiles=anki,cron,discord,flatpak,git,intellij,keepassxc,lgog-downloader\
,mgba,dropbox,proprietary-nvidia-drivers,psensor,qbittorrent\
,qdirstat,rustlang,shellcheck,steam,tmux,vim,wine,xfce

./setup.sh --profiles="$profiles"
