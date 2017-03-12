if command -v gem > /dev/null 2>&1; then
    echo_sh "** setup gem"
    gem install jekyll bundler starscope
    gem install sass compass
else
    echo_sh "ERROR: NO gem"
    exit
fi

