#!/bin/sh

concourse_url="$1"
team="$2"
pipeline_name="$3"
pipeline_config_path="$4"

if [ "$#" -lt 4 ]; then
        printf '%s usage: concourse_url team pipeline_name pipeline_config_path\n' "$0" >&2
        exit 1
fi

if [ -z "$concourse_url" ]; then
        printf '%s: concourse_url is blank / empty. Exiting...\n' "$0" >&2
        exit 1
fi

if [ -z "$team" ]; then
        printf '%s: team is blank / empty. Exiting...\n' "$0" >&2
        exit 1
fi

if [ -z "$pipeline_name" ]; then
        printf '%s: pipeline_name is blank / empty. Exiting...\n' "$0" >&2
        exit 1
fi

if [ -z "$pipeline_config_path" ]; then
        # current directory
        pipeline_config_path='./pipeline.yml'
fi

fly-login.sh "$concourse_url" "$team"


fly -t main set-pipeline -n "$team" --pipeline "$pipeline_name" \
        --config "$pipeline_config_path"
