#!/bin/sh

case "$(uname)" in
    "Darwin")
        export PATH="/usr/local/opt/llvm/bin:$PATH"
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
