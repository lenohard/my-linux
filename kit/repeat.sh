#!/usr/bin/env bash
echo "executing: $@"

declare -i n=0

until eval $@;
do
    n=$((n+1))
    echo "repeat $n times"
    sleep 1
done
