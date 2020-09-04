#!/usr/bin/bash

#Variables

git_path=$(which git)
if [ $git_path = "" ] ; then
  echo "ERROR: GIT binary not found"
  exit 20
fi
commit_id_01="$($git_path log --pretty=oneline |awk 'NR==1 {print $1}')"
commit_id_02="$($git_path log --pretty=oneline |awk 'NR==2 {print $1}')"
out_path="."
out_file="ComponentChanges.csv"
prefix=$RANDOM
if [ "$commit_id_01" = "" -o "$commit_id_02" = "" ] ; then
  echo "ERROR: GIT binary not found"
  exit 21
fi

#MAIN

$git_path status 2>&1 > /dev/null
if [ $? -eq 0 ] ; then
  :
else 
  echo "ERROR: Not a Valid Repo"
  exit 22
fi

# Creating file with modifiles

$git_path diff $commit_id_01 $commit_id_02 --name-status --diff-filter=M | awk '{print $2}'> "$out_path/$prefix-$out_file"
cat "$out_path/$prefix-$out_file"

exit 0
