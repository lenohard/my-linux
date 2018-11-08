#!/bin/bash

hosts=("arch" "wdh" "elementary")

iplookup() {
    if nmblookup "$1" >/dev/null
    then
        nmblookup "$1" | awk '{print $1}'
        return 0
    else
        return 1
    fi
}

for host in "${hosts[@]}"
do
    #awk -v hst=$host '$2!~/^hst&/ {print $0}' /etc/hosts  > /etc/hosts
    # grep -wiv $host
    if nmblookup "$host" >/dev/null;then
        sed -in "/\b$host\b/d" /etc/hosts
        echo "$(iplookup $host)" "$host" >> /etc/hosts
    fi
done

vultr='64.156.14.43'
sed -in "/\bvultr\b/d" /etc/hosts
echo "$vultr vultr" >> /etc/hosts
