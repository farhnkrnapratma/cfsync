#!/bin/sh

# TODO: Work on this script until it's done.

push_date=$(date "+%F %T %z")

rm -rf ./nushell/history.txt
git add .
git commit -m "[$push_date] Updating configuration"
git push
