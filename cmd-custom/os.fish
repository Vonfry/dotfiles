#!/bin/sh

switch (uname)
    case "Darwin"
        set -x PATH /usr/local/opt/go/libexec/bin $PATH
        set -x PATH /usr/local/opt/sqlite/bin $PATH
        set -x PATH /usr/local/opt/gnu-tar/libexec/gnubin $PATH
        set -x PATH /usr/local/opt/curl/bin $PATH
        set -x PATH /usr/local/opt/llvm/bin $PATH
        set -x PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH
        set -x MANPATH /usr/local/opt/gnu-tar/libexec/gnuman $MANPATH
        set -x HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles
    case "Linux"
        source /etc/os-release
        switch $ID
            case "gentoo"
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
        end
end
