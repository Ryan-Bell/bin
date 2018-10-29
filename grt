#!/usr/bin/sh
#
# Summary: Simple script to toggle github remote to/from https/git.
#
# Depends: git

repo_remote="$(git remote get-url origin || exit 1)"

[ -z "$repo_remote" ] && exit 1

if ! echo "$repo_remote" | grep -q "github.com"; then
  exit 1
fi

if echo "$repo_remote" | grep -q "git@github"; then
    repo=$(echo "$repo_remote" | sed 's/git@github.com://')
    repo=$(echo "$repo" | sed 's/.git//')
    repo="https://github.com/${repo}"
else
    repo=$(echo "$repo_remote" | sed 's/https:\/\/github.com\///')
    repo="git@github.com:${repo}.git"
fi

printf "%s\\n" "Changing repo to $repo"

git remote set-url origin "$repo"
