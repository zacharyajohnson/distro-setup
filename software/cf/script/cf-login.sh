#!/bin/sh

pcf_api_url="$1"

if [ "$#" -lt 1 ]; then
        printf '%s usage: pcf_api_url\n' "$0" >&2
        exit 1
fi

# cf login will default to whatever URL to was used
# the last successful time if nothing is passed into
# it. If pcf_api_url is blank the shell will treat it
# as nothing being passed in and this behavior will happen
#
# We want to be as explicit as possible when login into pcf
# to do something
if [ -z "$pcf_api_url" ]; then
        printf '%s: pcf_api_url is blank / empty. Exiting...\n' "$0" >&2
        exit 1
fi

cf login -a "$pcf_api_url"
