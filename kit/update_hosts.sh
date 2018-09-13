#!/bin/bash

hosts=("arch" "wdh" "elementary")


for host in "${hosts[@]}"
do
    #awk -v hst=$host '$2!~/^hst&/ {print $0}' /etc/hosts  > /etc/hosts
    # grep -wiv $host
    sed -in "/\b$host\b/d" /etc/hosts
    echo $(nmblookup "$host" | awk '{print $1}') "$host" >> /etc/hosts
done

