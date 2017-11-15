echo_info "* system is Gentoo"
echo_info "** setup emerge and a lot of software"

echo_info "** This action must be run after the system is installed with all the basic things have been done."
echo_info "** All package.use flags are saved in the repo."

user_dir=$HOME
GENTOO_NEED_EXIT_USER=1
if [ $USER != "root" ]; then
    if command -v "sudo" > /dev/null 2>&1; then
        sudo -i
    else
        echo_sh "** Gentoo doesn't have sudo by default, so you must run the script with root user."
        su root
    fi
    GENTOO_NEED_EXIT_USER=0
fi

# global use flag
portage_dir=/etc/portage
for file in $script_dir/etc/portage/*; do
    cp -r -f $file /etc/portage/
done

echo "#\!/bin/sh" > /etc/portage/postsync.d/eix
echo "eix-remote update" >> /etc/portage/postsync.d/eix
echo "*" > /etc/eix-sync.conf

echo_note "--- Here may be a mask message when you install them, I recommand you to autounmask them by yourself. My use flag and other file only provide which I want to use. It isn't all the record for installing."

emerge-websync
emerge --sync --quiet

emerge --quiet app-admin/sudo
emerge --quiet app-portage/cpuid2cpuflags
emerge --quiet app-admin/eclean-kernel
emerge --quiet app-portage/gentoolkit app-portage/euses app-portage/genlop app-portage/eix app-portage/portage-utils
emerge --quiet app-portage/repoman
emerge --quiet app-portage/layman
layman-updater -R
layman -S

# system basic tools
emerge --quiet net-firewall/iptables
emerge --quiet app-admin/ulogd
rc-update add ulogd default
echo_note "--- Make sure you have a correct configure with iptables and then run `rc-update add iptables default`"
emerge --quiet net-firewall/firehol
emerge --quiet sys-apps/dbus

# shell
emerge --quiet net-misc/keychain
emerge --quiet app-shells/zsh app-shells/zsh-completions
emerge --quiet net-misc/wget net-misc/curl
emerge --quiet dev-vcs/git dev-vcs/git-lfs dev-vcs/git-flow dev-vcs/tig
emerge --quiet app-misc/screen
emerge --quiet dev-util/cmake sys-devel/gcc sys-devel/clang sys-devel/llvm dev-util/ninja
emerge --quiet dev-libs/poco dev-libs/boost dev-lang/swig
emerge --quiet sys-devel/gdb dev-util/lldb
emerge --quiet app-doc/doxygen dev-util/cloc
emerge --quiet app-text/tree games-misc/lolcat app-i18n/uchardet app-misc/colordiff
emerge --quiet app-shells/autojump app-shells/thefuck
emerge --quiet dev-util/shellcheck
emerge --quiet app-misc/cmatrix app-misc/figlet
emerge --quiet sys-process/htop

emerge --quiet sys-apps/ack sys-apps/the_silver_searcher sys-apps/gawk sys-apps/sed
emerge --quiet app-arch/zip
emerge --quiet dev-util/global dev-util/ctags dev-util/cscope dev-util/cflow
git clone --recursive https://github.com/Andersbakken/rtags.git $source_dir/rtags && cd $source_dir/rtags && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 . && make --quiet && cd - && ln -s -f $source_dir/rtags/bin/* $user_dir/.local/bin/ # rtags

# editor
emerge --quiet app-editors/vim
emerge --quiet app-editors/emacs
emerge --quiet app-text/editorconfig-core-c

# lang
layman -a haskell
emerge --quiet dev-lang/ghc dev-haskell/cabal dev-haskell/cabal-install dev-haskell/stack-bin
emerge --quiet dev-lisp/sbcl dev-lisp/gcl dev-lisp/clisp
emerge --quiet dev-lang/ruby dev-ruby/rubygems dev-ruby/bundler
git clone https://github.com/rbenv/rbenv.git $source_dir/rbenv  && cd $source_dir/rbenv && src/configure && make --quiet -C src && cd - && ln -s -f $source_dir/rbenv $user_dir/.rbenv # rbenv
emerge --quiet dev-lang/ocaml dev-ml/opam
emerge --quiet dev-lang/python dev-python/pip
emerge --quiet dev-lang/go net-libs/nodejs
emerge --quiet dev-db/sqlite dev-db/redis dev-db/mysql dev-db/postgresql
emerge --quiet app-text/poppler
emerge --quiet app-text/pandoc
emerge --quiet app-text/texlive app-office/texstudio
emerge --quiet dev-java/javacc

# system tools
emerge --quiet net-analyzer/wireshark
emerge --quiet net-irc/weechat

# X11
# TODO X11

echo_note "--- If you want to install docker, please install it by yourself. It needs some configure in kernel."
echo_note "--- If you want to patch kernel with pax, please emerge and build it by yoursef."

if [ GENTOO_NEED_EXIT_USER  == 0 ]; then
    logout
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

unset portage_dir
unset GENTOO_NEED_EXIT_USER
