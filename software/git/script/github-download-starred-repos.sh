#!/bin/sh

# This script will download all the starred repos
# for a user based on the $GITHUB_USERNAME environment variable

base_dir="$1"

if [ -z "$base_dir" ]; then
        printf '%s: Provide directory path to store GitHub repos\n' "$0" >&2
        exit 1
fi

if [ ! -d "$base_dir" ]; then
        printf '%s: Directory %s does not exist or is not a directory\n' "$0" "$base_dir" >&2
        exit 1
fi

if [ -z "$GITHUB_USERNAME" ]; then
        printf '%s: GITHUB_USERNAME environment variable not set\n' "$0" >&2
        exit 1
fi

if [ -z "$GITHUB_READ_TOKEN" ]; then
        printf '%s: GITHUB_READ_TOKEN envirnoment variable not set. Please provide read only api token for GitHub\n' "$0" >&2
        exit 1
fi

echo "Storing repos at $base_dir"
echo "Downloading starred repos for user $GITHUB_USERNAME"

github_starred_repos_endpoint="https://api.github.com/users/$GITHUB_USERNAME/starred?per_page=100"

while [ -n "$github_starred_repos_endpoint" ]; do
        # The full response
        response="$(curl -s -H "Authorization: token $GITHUB_READ_TOKEN" "$github_starred_repos_endpoint")"

        # The data we care about
        response_data="$(echo "$response" | jq 'map({owner_username: .owner.login, repo_path: .full_name, clone_url: .clone_url})')"

        echo "$response_data" | jq -c '.[]' | while read -r i; do
               owner_username="$(echo "$i" | jq -r '.owner_username')"
               repo_path="$(echo "$i" | jq -r '.repo_path')"
               repo_url="$(echo "$i" | jq -r '.clone_url')"
               repo_clone_path="$base_dir/$repo_path"


               # GitHub in its infinite wisdom doesn't unstar a repo
               # after it is DMCA claimed so it halts the program when
               # trying to grab it
               if [ "$repo_path" = 'rmonvfer/yandereSimulatorSource' ]; then
                       echo "$repo_url has been DMCA claimed. Skipping..."
                       continue
               fi


               if [ -d "$repo_clone_path" ]; then
                       cd "$repo_clone_path" || exit
                       if git rev-parse --show-toplevel > /dev/null 2>&1; then
                               echo "$repo_url exists in $repo_clone_path. Updating..."
                               git fetch --all --prune --prune-tags --force
                               cd "$base_dir" || exit
                               #sleep 10s
                               continue
                       else
                               echo "Directory $repo_clone_path exists but isn't a git directory. Skipping..."
                               #sleep 5s
                               cd "$base_dir" || exit
                       fi
               else
                       mkdir -p "$repo_clone_path"
                       cd "$base_dir" || exit
                       echo "Cloning $repo_url from user $owner_username into $repo_path"
                       #sleep 10s

                       git clone --no-checkout "$repo_url" "$repo_clone_path" > '/dev/null'
               fi
        done

        github_starred_repos_endpoint="$(curl -sI -H "Authorization: token $GITHUB_READ_TOKEN" "$github_starred_repos_endpoint" | grep -i '^Link:' | sed -n 's/.*<\([^>]\+\)>;[[:space:]]*rel="next".*/\1/p')"
done

