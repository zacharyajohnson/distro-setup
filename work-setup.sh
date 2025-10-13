#!/bin/sh

# Change shell to bash because bash is typically what is used
# to run any kind of scripts / batch jobs at work
#
# Macs default to zsh now so change that for local
# development as well
chsh -s /bin/bash

software=azure-cli,cf,fly,git,k9s,kubectl,kubelogin,python-3,shellcheck,safe,sshpass,tmux,vim,visual-vm

./setup.sh --software="$software" --prompt-for-install --native-and-non-native-packages
