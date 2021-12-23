#!/bin/sh

# Copy .bashrc and .bash_profile config files to home folder
sudo cp .bashrc $HOME/.bashrc && sudo cp .bash_profile $HOME/.bash_profile && \

        #Since we copy over a generic bash_profile above each time this is run, we don't have to worry about checking the edge case if the user hasn't logged out and updated the PATH variable
        #but the updated PATH variable exists in the .bash_profile file itself. We just wipe it clean each time and start over. So we only have to check if the folder is on the current PATH itself.
	#If the bin folder for some reason exists on the PATH, we just use $PATH in our export statment instead of adding it, otherwise we add $HOME/bin to the path.
	#This effectivly handles the case if the script is run multiple times as well
	if echo "$PATH" | grep -q $HOME/bin
	then
		echo "$HOME/bin already on path, using current PATH variable" && sleep 2s
		echo "export PATH=$PATH" | sudo tee -a $HOME/.bash_profile
	else
		echo "adding $HOME/bin to PATH variable..." && echo "Please login again to see PATH variable changes!" && sleep 2s
	        echo "export PATH=$HOME/bin:$PATH" | sudo tee -a $HOME/.bash_profile
	fi


