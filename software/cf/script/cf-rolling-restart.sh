#!/bin/sh

pcf_api_url="$1"
pcf_app_name="$2"

if [ "$#" -lt 2 ]; then
        printf '%s usage: pcf_api_url pcf_app_name\n' "$0" >&2
        exit 1
fi

if [ -z "$pcf_api_url" ]; then
        printf '%s: pcf_api_url is empty / blank. Exiting...\n' "$0" >&2
        exit 1
fi

if [ -z "$pcf_app_name" ]; then
        printf '%s: pcf_app_name is empty / blank. Exiting...\n' "$0" >&2
        exit 1
fi

if ! cf-login.sh "$pcf_api_url"; then
        printf '%s: cf-login.sh failed. Exiting...\n' "$0" >&2
        exit 1
fi

echo "$0: Are you sure you want to rolling restart $pcf_app_name?"
read -r answer

if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ]; then
        cf rolling-restart "$pcf_app_name"
else
        printf '%s: Aborting rolling restart for %s\n' "$0" "$pcf_app_name" >&2
        exit 1
fi
