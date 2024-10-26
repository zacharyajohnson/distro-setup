#!/bin/sh

pcf_api_url="$1"
pcf_app_name="$2"

if [ "$#" -lt 2 ]; then
        echo "$0 usage: pcf_api_url pcf_app_name" >&2
        exit 1
fi

if [ -z "$pcf_api_url" ]; then
        echo "$0: pcf_api_url is empty / blank. Exiting..." >&2 
        exit 1
fi

if [ -z "$pcf_app_name" ]; then
        echo "$0: pcf_app_name is empty / blank. Exiting..." >&2 
        exit 1
fi

if ! cf-login.sh "$pcf_api_url"; then
        echo "$0: cf-login.sh failed. Exiting..." >&2
        exit 1
fi

echo "$0: Are you sure you want to rolling restart $pcf_app_name?"
read -r answer

if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ]; then
        cf rolling-restart "$pcf_app_name"
else
        echo "$0: Aborting rolling restart for $pcf_app_name" >&2
        exit 1
fi
