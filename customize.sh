#!/bin/bash
icon_dir=$1
PWA_PREFIX=$2
APP[0]="opera"
APP[1]="firefox"
case $1 in
  -h)
       echo "Run 'pwashortcut -h' for more information"
       echo "Run 'pwashortcut -i' for available preinstalled icons"
       ;;
  -i)
       echo "Available preinstalled themes:"
       echo ${APP[*]}
       exit 0
       ;;
esac
################################################
echo "Making a customize PWA configuration"
read -p "Application Name: " appname
if [[ " ${APP[*]} " == *" $appname "* ]] 
then
    read -r -p "${appname^} has a preinstalled customize theme, do you wanna use it? [y/N] " appname_response
    case "$appname_response" in
      [yY][eE][sS]|[yY]) 
        cp $icon_dir/$appname.json $PWA_PREFIX/$appname/templates/manifest.json
        echo "Using preinstalled configuration"
        exit 0
        ;;
    esac
fi
read -p "Enter path of the icon you want to use in ${appname^}:" icon_path
read -p "Enter the window color of PWA you want to use in HEX (without #):" window_color
read -p "Enter the background color of PWA you want to use in HEX (without #):" background_color
cp $icon_path $PWA_PREFIX/$appname/icon/brew.png
sed 's/000000/$window_color/1' $PWA_PREFIX/$appname/templates/manifest.json
sed 's/000000/$background_color/2' $PWA_PREFIX/$appname/templates/manifest.json
echo "A customize PWA configuration file for ${appname^} created!"
