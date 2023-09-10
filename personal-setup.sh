#!/bin/sh

profiles=$(echo anki,discord,git,intellij,keepassxc,lgog-downloader\
,lutris,mgba,dropbox,proprietary-nvidia-drivers,psensor,qbittorrent\
,qdirstat,rustlang,sddm,shellcheck,steam,tmux,vim,wine)

./setup.sh --profiles="$profiles"
