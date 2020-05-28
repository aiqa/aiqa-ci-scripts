#!/usr/bin/env bash

## 1. Master branch
git checkout master

git describe
git log -1 --oneline
git status -sb

### Update branch to date
git fetch
git rebase

### Version up
stamp patch:up
git push
git push --tags

git describe
git log -1 --oneline
git status -sb
