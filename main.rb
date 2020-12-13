require 'FileUtils'

system "cat <<'EOF'> pwashortcut
#!/bin/bash
# A simple start script
export CREW_PREFIX=#{CREW_PREFIX}
export PYTHONPATH=$CREW_PREFIX/lib/python3.9/site-packages/
export PWA_PREFIX=$CREW_PREFIX/lib/pwa
export tools=$PWA_PREFIX/tools
export FLASK_APP=$PWA_PREFIX/main.py
export FLASK_ENV=development
pkill flask
case ${1} in
    -h)
          echo  '
===================================
    Shortcut Server Starter
  -s (Default option) Start shortcut server
  -n (App Name)       Make a new shortcut
  -h                  Show this message
  -p                  Set py script path
  -y                  Set PYTHONPATH
  -f                  Pass option to Flask
  -g                  PWA icon chooser
  -i                  Available preinstalled icons for PWA icon chooser
==================================='
          ;;
    -i)
          bash $tools/customize.sh -i
          ;;
    -g)   
          bash $tools/customize.sh $tools/icon/ $PWA_PREFIX
          ;;
    -n)
          mkdir -p $PWA_PREFIX/$2/templates
          cp -r $tools/* $PWA_PREFIX/$2/templates
          mv $PWA_PREFIX/$2/templates/manifest.json.bak $PWA_PREFIX/$2/templates/manifest.json
          sed -i \"s/linuxapp/${2^}/g\" $PWA_PREFIX/$2/templates/manifest.json
          sed -i \"s/unixapp/$2/g\" $PWA_PREFIX/$2/templates/manifest.json
          #######################
          echo \" \" >> $FLASK_APP
          echo \"@app.route('/$2/$2.app')\" >> $FLASK_APP
          echo \"def $2():\" >> $FLASK_APP
          echo \"  def $2_run():\" >> $FLASK_APP
          echo \"    os.system('$2')\" >> $FLASK_APP
          echo \"  start_$2 = Thread(target=$2_run)\" >> $FLASK_APP
          echo \"  start_$2()\" >> $FLASK_APP
          echo \"  return 'You can close this window now'\" >> $FLASK_APP
          echo \"@app.route('/$2/')\" >> $FLASK_APP
          echo \"def installer_$2():\" >> $FLASK_APP
          echo \"    return render_template('installer.html')\" >> $FLASK_APP
          echo \"@app.route('/$2/<path:path>')\" >> $FLASK_APP
          echo \"def $2_path(path):\" >> $FLASK_APP
          echo \"    if path.endswith(('.png', 'manifest.json')):\" >> $FLASK_APP
          echo \"        return send_from_directory('$2/templates', path)\" >> $FLASK_APP
          echo \" \" >> $FLASK_APP
          #######################
          echo \"Shortcut for ${2^} deployed!\"
          echo \"Wait for server start and go to localhost:5000/$2/ for installing shortcut.\"
          sleep 2
          flask run
          ;;
    -s)
          flask run
          ;;
    *)
          getopts \"p:y:f:*\" arg
          OPTARG=$(echo ${OPTARG} | sed 's/\=//')
          RUN=NO
          case ${arg} in
                 p)
                     RUN=YES
                     export FLASK_APP=$OPTARG
                     flask run
                     ;;
                 y)
                     RUN=YES
                     export PYTHONPATH=$OPTARG
                     flask run
                     ;;
                 f)  
                     RUN=YES
                     flask run $OPTARG
                     ;;
                 *)  
                     echo \"Error: unknown option '$arg'\"
                     echo \"Try 'pwashortcut -h' for more options.\"
                     ;;
          esac
          if [[ $RUN != YES ]]; then pwashortcut -h; fi
          ;;
esac
EOF"
system "cp pwashortcut /usr/local/bin/"
