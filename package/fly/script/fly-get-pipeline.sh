#!/bin/sh

concourse_url="$1"
team="$2"
pipeline_name="$3"

if [ "$#" -lt 3 ]; then
        printf '%s usage: concourse_url team pipeline_name\n' "$0" >&2
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

fly-login.sh "$concourse_url" "$team"


fly -t main get-pipeline --pipeline "$pipeline_name"
