#!/bin/sh

software=anki,cron,discord,flatpak,git,intellij,keepassxc,lgog-downloader\
,mgba,nautilus-dropbox,proprietary-nvidia-driver,psensor,qbittorrent\
,qdirstat,rustlang,shellcheck,steam,tmux,vim,wine,xfce

./setup.sh --software="$software"
