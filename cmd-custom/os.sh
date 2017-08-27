#!/bin/sh

case "$(uname)" in
    "Darwin")
        export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
        export PATH="/usr/local/opt/curl/bin:$PATH"
        export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
        export PATH="/usr/local/opt/llvm/bin:$PATH"
        export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
        alias llvm-help="
        To use the bundled libc++ please add the following LDFLAGS:
        LDFLAGS=\"-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib\"
        compile with configure:
        LDFLAGS:  -L/usr/local/opt/llvm/lib
        CPPFLAGS: -I/usr/local/opt/llvm/include"
        ;;
    "Linux")
        source /etc/os-release
        case "$ID" in
            "fedora")
                ;;
            "gentoo")
                ;;
        esac
        ;;
esac
