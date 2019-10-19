#!/bin/sh

comment=${1:-"Default Message"}

git add -A
git commit -m "${comment}"
git pull
git push

