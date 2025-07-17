#!/bin/sh

push_date=$(date "+%F %T %z")

rm -rf ./nushell/history.txt
git add .
git commit -m "[$push_date] Updating configuration"
git push
