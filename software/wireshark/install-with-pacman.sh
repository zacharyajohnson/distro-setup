#!/bin/sh

sudo pacman -S wireshark-qt 

sudo usermod -a -G wireshark "$USER"
