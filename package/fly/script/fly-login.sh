#!/bin/sh

concourse_url="$1"
team="$2"

if [ "$#" -lt 2 ]; then
        printf '%s usage: concourse_url team\n' "$0" >&2
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

fly -t main login --concourse-url "$concourse_url" --team-name "$team"
