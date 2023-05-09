# shellcheck disable=SC2148

# If bashrc exists, load it since bashrc typically only loads for non-interactive shells
if [ -f "$HOME/.bashrc" ]
then
        # shellcheck source=/dev/null
	. "$HOME/.bashrc"
fi
