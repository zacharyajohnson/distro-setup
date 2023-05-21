#!/bin/sh

sudo dpkg --add-architecture i386 && sudo apt update

sudo apt-get install -y wine \
        wine32 \
        wine64 \
        libwine \
        libwine:i386 \
        fonts-wine
