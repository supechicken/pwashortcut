#!/bin/bash
CREW_PREFIX=$2
PWA_PREFIX=$CREW_PREFIX/lib/pwa
appname=$3
icon=$1
webpath=$4
path=$CREW_PREFIX/share/pixmaps
icon () { ls -1 $path 2> /dev/null | grep $icon; }
num=`icon | wc -l`
if [[ "$num" != "0" ]]
then
if [[ "$num" != "1" ]]
then
echo "$num icons were found for $appname"
icon
read -r -p "Which icon you want to use?" appname_response
iconpath=$path/$appname_response
else
iconpath=$path/`icon`
fi
if [[ $iconpath = *.xpm ]]
then
convert $iconpath ${iconpath}.png
cp ${iconpath}.png $PWA_PREFIX/$webpath/templates/icon/brew.png
rm ${iconpath}.png
else
echo $iconpath
cp $iconpath $PWA_PREFIX/$webpath/templates/icon/brew.png
fi
else
echo "No icon were found for $appname :/"
fi
