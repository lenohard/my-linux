#!/bin/bash
IFS=$'\t'
results=`locate -ibA  $*`
pick.sh `echo $results` 
echo '

'


