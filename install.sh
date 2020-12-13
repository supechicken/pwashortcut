curl https://github.com/supechicken666/pwashortcut/archive/testing.tar.gz -#o test.tgz
tar xvf test.tgz
mkdir -p /usr/local/lib/pwa/tools/
mkdir -p /usr/local/lib/pwa/templates/
cp installer.html /usr/local/lib/pwa/templates/
cp main.py /usr/local/lib/pwa/
mv * /usr/local/lib/pwa/tools/
ruby main.rb
echo "Installed"
