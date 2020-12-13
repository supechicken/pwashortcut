wget https://github.com/supechicken666/pwashortcut/archive/testing.zip
unzip test.zip
mkdir -p /usr/local/lib/pwa/tools/
mkdir -p /usr/local/lib/pwa/templates/
cp pwashortcut-testing/installer.html /usr/local/lib/pwa/templates/
cp pwashortcut-testing/main.py /usr/local/lib/pwa/
mv * /usr/local/lib/pwa/tools/
ruby pwashortcut-testing/main.rb
echo "Installed"
