#!/bin/bash

apt-get update

apt-get install -y vim 

apt-get install -y openssh-client openssh-server

#Install git and clone .vim project 
apt-get install -y git

# move vim config files to $HOME/.vim
mkdir -p $HOME/.vim && cp -r config/vim/* $HOME/.vim

# Set gits default editor to vim and setup my username and email 
git config --global core.editor vim
git config --global user.name "Zachary Alan Johnson"
git config --global user.email zjohnson366@gmail.com

# Install steel bank common lisp
apt-get install -y sbcl
# Install tmux
apt-get install -y tmux

# Copy .bashrc and .bash_profile config files to home folder
cp config/bash/.bashrc ~/.bashrc && cp config/bash/.bash_profile ~/.bash_profile

#Creating a bin directory at the current logged in users home and add it to the PATH variable so we can execute any scripts that are convenent to run anywhere
echo "creating $HOME/bin" && mkdir -p $HOME/bin && \
	#Since we copy over a generic bash_profile above each time this is run, we don't have to worry about checking the edge case if the user hasn't logged out and updated the PATH variable
	#but the updated PATH variable exists in the .bash_profile file itself. We just wipe it clean each time and start over. So we only have to check if the folder is on the current PATH itself.
	#If the bin folder for some reason exists on the PATH, we just use $PATH in our export statment instead of adding it, otherwise we add $HOME/bin to the path.
	#This effectivly handles the case if the script is run multiple times as well
	if grep -q $HOME/bin <<< $PATH 
	then
		echo "$HOME/bin already on path, using current PATH variable in .bash_profile" && sleep 2s
		echo "export PATH='$PATH'" >> ~/.bash_profile
	else
		echo "adding $HOME/bin to PATH variable..." && echo "Please login again to see PATH variable changes!" && sleep 2s
       		echo "export PATH='$HOME/bin:$PATH'" >> ~/.bash_profile 
	fi

# Move config files for custom tmux setups to the bin folder so they can be executed anywhere
cp tmux/tmux-slime-lisp.sh ~/bin


