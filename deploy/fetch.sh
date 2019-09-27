#!/bin/sh

set -e
pwd
cd _site
remote="https://${GH_TOKEN}@github.com/namtx/namtx.github.io.git"

git config --global user.email "$GH_EMAIL" > /dev/null 2>&1
git config --global user.name "$GH_NAME" > /dev/null 2>&1
git init
git remote add --fetch origin "$remote"

git add -A
git commit --allow-empty -m "Deploy to GitHub pages [ci skip]"
git push --force --quiet origin master
