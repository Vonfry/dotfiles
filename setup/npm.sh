if command -v npm > /dev/null 2>&1; then
    echo_sh "** setup npm"
    npm install -g bower
    npm install -g typescript tern
    npm install -g cordova
    npm install -g less less-plugin-clean-css
    npm install -g npm-check
    npm install -g font-spider
    npm install -g diff-so-fancy
    npm install -g @angular/cli
else
    echo_sh "ERROR: NO npm"
    exit
fi
