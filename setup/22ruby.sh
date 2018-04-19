echo_info "** setup ruby"

if command -v gem > /dev/null 2>&1; then
    echo_info "*** setup gem"
    gem sources --remove https://rubygems.org/  #移除默认源
    gem sources -a https://mirrors.ustc.edu.cn/rubygems/  #添加科大源
    gem install --silent --no-lock -g $script_dir/config/pkgs/gem.txt
    if command -v bundle > /dev/null 2>&1; then
        bundle config mirror.https://rubygems.org https://mirrors.ustc.edu.cn/rubygems/
    else
        echo_info "!!!! WARN: Ruby bundle isn't installed. The mirror haven't been set."
    fi
    ln -s -f $script_dir/pryrc ~/.pryrc
else
    echo_warn "!!! ERROR: NO gem"
    exit 1
fi

