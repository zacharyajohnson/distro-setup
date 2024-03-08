#!/bin/sh

sudo pacman -S cronie
sudo systemctl enable cronie.service
sudo systemctl start cronie.service
