#!/bin/sh

package=cron,git,jq,noto-fonts,shellcheck,smartmontools,tmux,unzip,vim\

"$(dirname "$0")"'/setup.sh' --package="$package" --prompt-for-install --native-and-non-native-packages
