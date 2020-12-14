#!/bin/bash
wget https://github.com/supechicken666/pwashortcut/archive/testing.zip
unzip testing.zip
mkdir -p /usr/local/lib/pwa/tools/
mkdir -p /usr/local/lib/pwa/templates/
cp pwashortcut-testing/installer.html /usr/local/lib/pwa/templates/
cp pwashortcut-testing/main.py /usr/local/lib/pwa/
cp -r pwashortcut-testing/* /usr/local/lib/pwa/tools/
mv /usr/local/lib/pwa/tools/brew_transparent_546x546.png /usr/local/lib/pwa/tools/brew.png
mv pwashortcut-testing/find.sh /usr/local/lib/pwa/tools/
ruby pwashortcut-testing/main.rb
echo "Installed"
