#!/bin/sh

concourse_url="$1"
team="$2"

if [ "$#" -lt 2 ]; then
        echo "$0 usage: concourse_url team" >&2
        exit 1
fi

if [ -z "$concourse_url" ]; then
        echo "$0: concourse_url is blank / empty. Exiting..." >&2
        exit 1
fi

if [ -z "$team" ]; then
        echo "$0: team is blank / empty. Exiting..." >&2
        exit 1
fi

fly -t main login --concourse-url "$concourse_url" --team-name "$team"
