#!/bin/sh

if [ apt ];
then
        install_command='apt-get install -y'
elif [ brew ];
then
        install_command='brew install'
else
        echo 'Could not find valid package manager. Aborting...'
        exit 1
fi

echo "Setting package install command to: $install_command"

sudo $install_command vim

sudo $install_command openssh-client openssh-server

#Install git 
sudo $install_command git

#Install GNU Compiler Collection 
sudo $install_command gcc

#Install Ctags for C/C++ development
sudo $install_command ctags

# Copy git config file over
sudo cp config/git/.gitconfig $HOME

# move vim config files to $HOME/.vim
sudo mkdir -p $HOME/.vim && sudo cp -r config/vim/* $HOME/.vim && sudo chown -R $USER $HOME/.vim

# Install steel bank common lisp
sudo $install_command sbcl

# Install tmux
sudo $install_command tmux
#Copy tmux config file over
sudo cp config/tmux/.tmux.conf $HOME

# Copy .bashrc and .bash_profile config files to home folder
sudo cp config/bash/.bashrc $HOME/.bashrc && sudo cp config/bash/.bash_profile $HOME/.bash_profile

#Creating a bin directory at the current logged in users home and add it to the PATH variable so we can execute any scripts that are convenent to run anywhere
echo "creating $HOME/bin" && sudo mkdir -p $HOME/bin && \
	#Since we copy over a generic bash_profile above each time this is run, we don't have to worry about checking the edge case if the user hasn't logged out and updated the PATH variable
	#but the updated PATH variable exists in the .bash_profile file itself. We just wipe it clean each time and start over. So we only have to check if the folder is on the current PATH itself.
	#If the bin folder for some reason exists on the PATH, we just use $PATH in our export statment instead of adding it, otherwise we add $HOME/bin to the path.
	#This effectivly handles the case if the script is run multiple times as well
	if echo "$PATH" | grep -q $HOME/bin
	then
		echo "$HOME/bin already on path, using current PATH variable in .bash_profile" && sleep 2s
		echo "export PATH=$PATH" | sudo tee -a $HOME/.bash_profile
	else
		echo "adding $HOME/bin to PATH variable..." && echo "Please login again to see PATH variable changes!" && sleep 2s
	        echo "export PATH=$HOME/bin:$PATH" | sudo tee -a $HOME/.bash_profile
	fi

# Move config files for custom tmux setups to the bin folder so they can be executed anywhere
sudo cp tmux/tmux-slime-lisp.sh $HOME/bin
