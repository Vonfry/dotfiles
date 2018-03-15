#!/bin/sh

case "$(uname)" in
    "Darwin")
        export PATH="/usr/local/opt/go/libexec/bin:$PATH"
        export PATH="/usr/local/opt/sqlite/bin:$PATH"
        export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
        export PATH="/usr/local/opt/curl/bin:$PATH"
        export PATH="/usr/local/opt/llvm/bin:$PATH"
        export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
        export fpath=(/usr/local/share/zsh-completions $fpath)
        export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
        export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
        alias llvm-help=" echo \"
        To use the bundled libc++ please add the following LDFLAGS:
        LDFLAGS=\"-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib\"
        compile with configure:
        LDFLAGS:  -L/usr/local/opt/llvm/lib
        CPPFLAGS: -I/usr/local/opt/llvm/include\""
        ;;
    "Linux")
        source /etc/os-release
        case "$ID" in
            "fedora")
                ;;
            "gentoo")
                alias eqf='equery f'
                alias equ='equery u'
                alias eqh='equery h'
                alias eqa='equery a'
                alias eqb='equery b'
                alias eql='equery l'
                alias eqd='equery d'
                alias eqg='equery g'
                alias eqc='equery c'
                alias eqk='equery k'
                alias eqm='equery m'
                alias eqy='equery y'
                alias eqs='equery s'
                alias eqw='equery w'
                ;;
        esac
        ;;
esac
