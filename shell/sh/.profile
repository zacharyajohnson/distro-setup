#!/bin/sh

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

if [ -f "$HOME/.aliases.sh" ]; then
        . "$HOME/.aliases.sh"
fi

for export_file in $( echo ./.*export.sh | sed 's/.\///g' )
do
        if echo "$export_file" | grep -E '^\.{1}[a-zA-Z0-9_-]*export.sh' > /dev/null 2>&1; then
                . "$export_file"
        fi
done
