echo_info "* system is Gentoo"
echo_info "** setup emerge and a lot of software"

echo_sh "** This action must be run after the system is installed with all the basic things have been done."
echo_sh "** All package.use flags are saved in the repo."

user_dir=$HOME
GENTOO_NEED_EXIT_USER=1
if [ $USER != "root" ]; then
    echo_sh "** Gentoo doesn't have sudo by default, so you must run the script with root user."
    su root
    GENTOO_NEED_EXIT_USER=0
fi

# global use flag
portage_dir=/etc/portage
echo "LINGUAS=\"en zh-CN jp\"" > $portage_dir/make.conf
echo "USE=\"aac berkdb bzip2 cjk cscope curl clipboard cvs cxx dbus doc examples ffmpeg flac git gif gpm graphviz gtk gzip icu ipv6 java javascript jpeg latex libedit libffi libressl lua mmap multilib mp3 mp4 music mysql ocaml ogg perl pdf png postgresql posix  python ruby sockets soap samba source spell sqlite static-libs svg syslog systemd ssl sound tcpd threads tiff tidy unicode usb vhosts videos vnc webkit xml yaml zlib zsh-completion\"" >> $portage_dir/make.conf # USE in make.conf only saves the global use flag.
echo "LLVM_TARGETS=\"AMDGPU WebAssembly\"" >> $portage_dir/make.conf
for file in $script_dir/etc/portage/*; do
    rm "$portage_dir/${file##*/}"
    ln -s -f $file* /etc/portage/
done

emerge-websync

emerge app-admin/sudo
emerge app-admin/eclean app-admin/eclean-kernel
emerge app-portage/gentoolkit app-portage/euses
emerge app-portage/layman
layman-updater -R
layman -S

# system basic tools
emerge net-firewall/iptabels
rc-update add iptabels default
emerge net-firewall/ferm
emerge sys-apps/dbus

# shell
emerge app-shells/zsh app-shells/zsh-completions
emerge net-misc/wget net-misc/curl
emerge dev-vcs/git dev-vcs/git-lfs dev-vcs/tig
emerge app-misc/screen
emerge dev-util/cmake sys-devel/gcc sys-devel/clang sys-devel/llvm dev-util/ninja sys-devel/automake
emerge dev-libs/poco dev-libs/boost dev-libs/thrift dev-libs/swig
emerge sys-devel/gdb dev-util/lldb
emerge app-doc/doxygen dev-util/cloc
emerge app-text/tree games-misc/lolcat app-i18n/uchardet app-misc/colordiff
emerge app-shells/autojump app-shells/thefuck
emerge dev-util/shellcheck
emerge app-misc/cmatrix app-misc/figlet

emerge sys-apps/ack sys-apps/the_silver_searcher sys-apps/gawk sys-apps/sed
emerge app-arch/zip
emerge dev-util/global dev-util/ctags dev-util/cscope
git clone --recursive https://github.com/Andersbakken/rtags.git $source_dir/rtags && cd $source_dir/rtags && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 . && make && cd - && ln -s -f $source_dir/rtags/bin/* $user_dir/.local/bin/ # rtags

# editor
emerge app-editors/vim
emerge app-editors/neovim
emerge app-editors/emacs
emerge app-tex/editorconfig-core-c

# lang
layman -a haskell
emerge dev-lang/ghc dev-haskell/cabal dev-haskell/cabal-install dev-haskell/stack-bin
emerge dev-lisp/sbcl dev-lisp/gcl dev-lisp/clisp
emerge dev-lang/ruby dev-ruby/rubygems
git clone https://github.com/rbenv/rbenv.git $source_dir/rbenv  && cd $source_dir/rbenv && src/configure && make -C src && cd - && ln -s -f $source_dir/rbenv $user_dir/.rbenv # rbenv
emerge dev-lang/ocaml dev-ml/opam
emerge dev-lang/python dev-python/pip
emerge dev-lang/go net-libs//nodejs
emerge dev-db/sqlite dev-db/redis dev-db/mysql dev-db/postgresql
emerge app-text/poppler
emerge app-text/pandoc
emerge app-text/texlive app-office/texstudio
emerge dev/java/javacc

# system tools
emerge net-analyzer/wireshark
emerge net-irc/weechat

# X11
# TODO X11

if [ GENTOO_NEED_EXIT_USER  == 0 ]; then
    logout
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

unset portage_dir
