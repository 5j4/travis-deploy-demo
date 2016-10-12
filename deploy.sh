#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

pwd
cd build
pwd

git init
git config user.name "5j4"
git config user.email "5j4@users.noreply.github.com"

git remote add origin "https://${GHP_TOKEN}@github.com/5j4/travis-deploy-demo.git"
git fetch origin
git reset origin/gh-pages

# echo "rustbyexample.com" > CNAME

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages