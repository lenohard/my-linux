#!/bin/bash

cur_dir='$(pwd)'
cd $(git rev-parse --show-toplevel)

git status
read -p  "Continue? [y]|n" -n 1 -r
echo

if  [[ $REPLY =~ ^[Yy]$ ]]
then
    git add .
    echo "message: " -n
    read m
    git commit -m "$m"
    git push
fi
