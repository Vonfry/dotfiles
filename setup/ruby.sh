echo_info "** setup ruby"

ln -f -s $script_dir/gem.txt ~/.gem.txt

if command -v gem > /dev/null 2>&1; then
    echo_info "*** setup gem"
    gem sources --remove https://rubygems.org/  #移除默认源
    gem sources -a https://mirrors.ustc.edu.cn/rubygems/  #添加科大源
    gem install -g $script_dir/gem.txt
    if command -v bundle > /dev/null 2>&1; then
        bundle config mirror.https://rubygems.org https://mirrors.ustc.edu.cn/rubygems/
    else
        echo_info "WARN: Ruby bundle isn't installed. The mirror haven't been set."
    fi
else
    echo_warn "!!! ERROR: NO gem"
    exit 1
fi

