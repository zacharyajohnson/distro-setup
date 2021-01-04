# If bashrc exists, load it since bashrc typically only loads for non-interactive shells
if [ -f $HOME/.bashrc ]
then
	source $HOME/.bashrc
fi

