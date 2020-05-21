#!/bin/bash


usage(){
  cmd="`basename $0`"
  echo "$cmd <source> <destination>"
  echo "$cmd /mnt/sdcard ."
}


if [ $# -lt 2 ];then
  usage
  exit 10
fi

source=$1
destination=$2

for file in $(adb shell find $source)
do
  relativepathtofile=`echo $file|sed "s/^\(\/\)\(.*\)/\\2/"`
  mkdir -p `dirname $relativepathtofile`
  echo adb pull $file "`dirname ${destination}`/${relativepathtofile}"
done

