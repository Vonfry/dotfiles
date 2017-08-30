echo_sh "* system is Gentoo"
echo_sh "** setup emerge and a lot of software"

echo_sh "** This action must be run after the system is installed with all the basic things have been done."
echo_sh "** All package.use flags are saved in the repo."
ln -s -f $script_dir/etc/portage/* /etc/portage/
echo "~$(portageq envvar ARCH)" >> /etc/portage/package.accept_keywords/local-arch

GENTOO_NEED_EXIT_USER=1
if [ $USER != "root" ]; then
    echo_sh "** Gentoo doesn't have sudo by default, so you must run the script with root user."
    su root
    GENTOO_NEED_EXIT_USER=0
fi

emerge-websync

emerge sudo

emerge app-admin/eclean
emerge app-portage/gentoolkit
emerge app-portage/layman
layman-updater -R
layman -f

# system basic tools
emerge net-firewall/iptabels
rc-update add iptabels default
emerge net-firewall/ferm
emerge sys-apps/dbus

# shell
emerge app-shells/zsh
emerge net-misc/wget net-misc/curl
emerge dev-vcs/git dev-vcs/git-lfs dev-vcs/tig
emerge app-misc/screen
emerge dev-util/cmake dev-util/gcc sys-devel/clang sys-devel/llvm dev-util/ninja sys-devel/automake
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
# TODO rtags

# editor
emerge app-editors/vim
emerge app-editors/neovim
emerge app-editors/emacs
emerge app-tex/editorconfig-core-c

# lang
layman -a haskell
emerge dev-lang/ghc dev-haskell/cabal dev-haskell/cabal-install dev-haskell/stack
emerge dev-lisp/sbcl dev-lisp/gcl dev-lisp/clisp
emerge dev-lang/ruby dev-ruby/rubygems # TODO rbenv
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
