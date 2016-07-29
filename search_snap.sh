#!/bin/bash

echo "###Snapshot Search Tool###"
echo "log will save in `pwd`/snap.log"
read -p "Please Enter your snapshot name (e.g. name1 or name1|name2|nameX) : " name
#echo $name

zfs list -o name -t snapshot |egrep "$name" > snap.log
