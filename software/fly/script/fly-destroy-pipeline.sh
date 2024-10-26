#!/bin/sh

concourse_url="$1"
team="$2"
pipeline_name="$3"

if [ "$#" -lt 3 ]; then
        echo "$0 usage: concourse_url team pipeline_name" >&2
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

if [ -z "$pipeline_name" ]; then
        echo "$0: pipeline_name is blank / empty. Exiting..." >&2
        exit 1
fi

fly-login.sh "$concourse_url" "$team"

fly -t main destroy-pipeline -n "$team" --pipeline "$pipeline_name"
