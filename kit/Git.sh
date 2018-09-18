#!/bin/bash

cur_dir="$(pwd)"
cd $(git rev-parse --show-toplevel)

git status
read -p  "Continue? (y|n)" -n 1 -r
echo

if  [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]
then
    git add .
    echo -n "Commit Message: "
    read m
    git commit -m "$m"
    git push
fi

cd "$cur_dir"
