#!/bin/sh

sudo pacman -S docker
sudo pacman -S docker-compose

sudo systemctl enable docker.socket
sudo systemctl start docker.socket

sudo usermod -a -G docker "$USER"
