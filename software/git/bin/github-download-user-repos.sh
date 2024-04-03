#!/bin/sh

# This script will download all the repos
# for a user based on the $GITHUB_USERNAME environment variable

base_dir="$1"

if [ -z "$base_dir" ]; then
        echo "$0: Provide folder path to store GitHub repos"
        exit 1
fi

if [ ! -d "$base_dir" ]; then
        echo "$0: Directory $base_dir does not exist or isn't a directory"
        exit 1
fi

if [ -z "$GITHUB_USERNAME" ]; then
        echo "$0: GITHUB_USERNAME environment variable not set"
        exit 1
fi

if [ -z "$GITHUB_READ_TOKEN" ]; then
        echo "$0: GITHUB_READ_TOKEN not set. Please provide read only api token for GitHub"
        exit 1
fi


echo "Storing repos at $base_dir"
echo "Downloading user repos for user $GITHUB_USERNAME"

github_user_repos_endpoint="https://api.github.com/users/$GITHUB_USERNAME/repos?per_page=100"

while [ -n "$github_user_repos_endpoint" ]; do
        # The full response
        response="$(curl -s -H "Authorization: token $GITHUB_READ_TOKEN" "$github_user_repos_endpoint")"

        # The data we care about
        response_data="$(echo "$response" | jq 'map({owner_username: .owner.login, repo_path: .full_name, clone_url: .clone_url})')"

        echo "$response_data" | jq -c '.[]' | while read -r i; do
               owner_username="$(echo "$i" | jq -r '.owner_username')"
               repo_path="$(echo "$i" | jq -r '.repo_path')"
               repo_url="$(echo "$i" | jq -r '.clone_url')"
               repo_clone_path="$base_dir/$repo_path"


               if [ -d "$repo_clone_path" ]; then
                       cd "$repo_clone_path"
                       if git rev-parse --show-toplevel > /dev/null 2>&1; then
                               echo "$repo_url exists in $repo_clone_path. Updating..."
                               git pull
                               cd "$base_dir"
                               #sleep 10s
                               continue
                       else
                               echo "Directory $repo_clone_path exists but isn't a git directory. Skipping..."
                               #sleep 5s
                               cd "$base_dir"
                       fi
               else
                       mkdir -p "$repo_clone_path"
                       cd "$base_dir"
                       echo "Cloning $repo_url from user $owner_username into $repo_path"
                       #sleep 10s

                       git clone "$repo_url" "$repo_clone_path" > '/dev/null'
               fi
        done

        github_user_repos_endpoint="$(curl -sI -H "Authorization: token $GITHUB_READ_TOKEN" "$github_user_repos_endpoint" | grep -i '^Link:' | sed -E -n 's/.*<([^>]+)>;[[:space:]]*rel="next".*/\1/p')"
done

