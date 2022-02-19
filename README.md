# adb



## udev detection
```bash
cp 51-android.rules /etc/udev/rules.d
                
````

## copy
```
cat copy.sh

export PATH=$PATH:~/.android-sdk-macosx/platform-tools

adb devices

directory=$PWD/$(date +%Y%m%d-%H%M)
mkdir $directory
time adb pull /mnt/sdcard/DCIM $directory

echo -e '
$ adb shell
$ ls /mnt/sdcard/DCIM/Camera

$ time adb pull /mnt/sdcard/DCIM $PWD

#for file in $(adb shell ls /mnt/sdcard/DCIM/Camera/20190531_*); do echo $file; adb pull $file .; done

'
```


```
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
  adb pull $file "`dirname ${destination}`/${relativepathtofile}"
done

```
