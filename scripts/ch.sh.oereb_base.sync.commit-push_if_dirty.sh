#!/bin/bash
# Try to fetch if there are differences
TIMESTAMP=$(date --iso-8601=seconds)
# sync with remote
git fetch -p

XML_CHANGES=$(git diff --name-only origin/master | grep ".xml" | wc -l)
ITF_CHANGES=$(git diff --name-only origin/master | grep ".itf" | wc -l)
XTF_CHANGES=$(git diff --name-only origin/master | grep ".xtf" | wc -l)

if [ "$XML_CHANGES" -eq "0" ] && [ "$ITF_CHANGES" -eq "0" ] && [ "$XTF_CHANGES" -eq "0" ]; then
  # if the word count of changes is 0 we can go on => no new itfs were pulled
  echo "  🟢 Git repo is clean => nothing to do."
else
  # we have a difference of data upstream => we will commit them to the repo and build a docker image
  echo "1" > /tmp/release
  echo "  🔴 Git repo dirty => committing changes and pushing"
  git commit . -m "updated repository on $TIMESTAMP from $UPSTREAM_URL"
  # push changes to github master
  git push
fi