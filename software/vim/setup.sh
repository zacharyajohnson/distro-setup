#!/bin/sh

$install_command vim

# move vim config files to $HOME/.vim
sudo mkdir -p $HOME/.vim && sudo cp -r config/* $HOME/.vim && sudo chown -R $USER $HOME/.vim
