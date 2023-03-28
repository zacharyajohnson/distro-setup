#!/bin/sh

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

if [ -f "$HOME/.aliases.sh" ]; then
        . "$HOME/.aliases.sh"
fi

for export_file in $(echo .*export.sh)
do
        if [ -e "$export_file" ]; then
                . "$export_file"
        fi
done

