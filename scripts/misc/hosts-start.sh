#!/bin/bash

set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
echo "back up /etc/hosts to /etc/hosts.bk"
set -x
sudo cp /etc/hosts /etc/hosts.bk
sudo cp ../hosts/hosts /etc/hosts
set +x


