#!/bin/sh

_get_native_package_manager() {
        if which dpkg > '/dev/null' 2>&1; then
                printf 'dpkg'
                return 0
        elif which pkg > '/dev/null' 2>&1; then
                printf 'pkg'
                return 0
        elif which pacman > '/dev/null' 2>&1; then
                printf 'pacman'
                return 0
        elif which apk > '/dev/null' 2>&1; then
                printf 'apk'
                return 0
        else
                return 1
        fi
}

_get_non_native_package_manager() {
        if which flatpak > '/dev/null' 2>&1; then
                printf 'flatpak'
                return 0
        elif which brew > '/dev/null' 2>&1; then
                printf 'brew'
                return 0
        else
                return 1
        fi

}
