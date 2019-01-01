ECHO_SYM="\033[0;31m"
ECHO_MSG="\033[0;36m"
ECHO_RST="\033[0m"
current_dir=$(pwd)
prefixsudo=""

case "$(uname)" in
    "Darwin")
        echo -e "\n${ECHO_SYM}* ${ECHO_MSG}system: $(uname)${ECHO_RST}"
        echo -e "\n${ECHO_SYM}** ${ECHO_MSG}homebrew${ECHO_RST}\n"
        brew update
        brew upgrade
        brew cask upgrade --greedy
        brew cleanup
        echo -e "\n${ECHO_SYM}** ${ECHO_MSG}app store${ECHO_RST}\n"
        sudo softwareupdate --install --all
        echo -e "\n${ECHO_SYM}--- ${ECHO_MSG}You may run /usr/local/opt/fzf/install to install fzf${ECHO_RST}"
        ;;
        # if ctags is updated, emacs needs being recompiled.
        "Linux")
        source /etc/os-release
        prefixsudo="sudo"
        echo -e "\n${ECHO_SYM}* ${ECHO_MSG}system: ${ID}${ECHO_RST}"
        case "$ID" in
            "fedora")
                echo -e "\n${ECHO_SYM}** ${ECHO_MSG}dnf${ECHO_RST}\n"
                sudo dnf clean all
                sudo dnf update -y
                sudo dnf clean all
                ;;
            "gentoo")
                echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage${ECHO_RST}"
                echo -e "\n${ECHO_SYM}** ${ECHO_MSG}sync portage and custom repos${ECHO_RST}\n"
                sudo eix-sync -q
                echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage self${ECHO_RST}\n"
                sudo emerge --update --oneshot --quiet portage
                echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage worlds${ECHO_RST}"
                echo -e "\n${ECHO_SYM}** ${ECHO_MSG}If use flag has been changed, run emerge with --newuse or --changed-use. This updating dosen't contain them.${ECHO_RST}\n"
                sudo emerge --quiet --update --with-bdeps=y @world
                echo -e "\n${ECHO_SYM}** ${ECHO_MSG}Run emerge --depclean --quiet if you want to clean old packages.${ECHO_RST}\n"
                ;;
        esac
        ;;
esac

if command -v antigen >/dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}antigen${ECHO_RST}\n"
    antigen update
    antigen selfupdate
fi

echo -e "\n${ECHO_SYM}* ${ECHO_MSG}sources${ECHO_RST}"
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}lsp${ECHO_RST}"
echo -e "\n${ECHO_SYM}--- ${ECHO_MSG}Please update by yourself. ${ECHO_RST}"

echo -e "\n${ECHO_SYM}* ${ECHO_MSG}haskell${ECHO_RST}"
if command -v cabal > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}cabal${ECHO_RST}\n"
    cabal update --verbose=0
fi
if command -v stack > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}stack${ECHO_RST}\n"
    stack update --silent
fi
if command -v hoogle > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}hoogle${ECHO_RST}\n"
    hoogle generate --quiet
fi
echo -e "\n${ECHO_MSG}All things with haskell are only updated with indexed file, please update each package by yourself."

echo -e "\n${ECHO_SYM}* ${ECHO_MSG}python${ECHO_RST}"
if command -v pip3 > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}pip3${ECHO_RST}\n"
    if [ -z $prefixsudo ]; then
        pip3 install --quiet --upgrade -r $DOTFILES_DIR/config/pkgs/pip3.txt
    else
        pip3 install --quiet --user --upgrade -r $DOTFILES_DIR/config/pkgs/pip3.txt
    fi
fi

if command -v pip2 > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}pip2${ECHO_RST}\n"
    if [ -z $prefixsudo ]; then
        pip2 install --quiet --upgrade -r $DOTFILES_DIR/config/pkgs/pip2.txt
    else
        pip2 install --quiet --user --upgrade -r $DOTFILES_DIR/config/pkgs/pip2.txt
    fi
fi

if command -v gem > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}ruby${ECHO_RST}"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}gem${ECHO_RST}\n"
    gem update --quiet && gem update --system --quiet
    gem cleanup --quiet
fi

if command -v npm > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}node${ECHO_RST}\n"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}npm${ECHO_RST}\n"
    $prefixsudo npm update -g --silent
fi

if [ -f ~/.config/nvim/init.vim ]; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}nvim${ECHO_RST}"
    echo -e "\n${ECHO_SYM}-- ${ECHO_MSG}Please update by yourself.${ECHO_RST}"
fi

if [ -f ~/.emacs.d/init.d ]; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}Emacs${ECHO_RST}"
    echo -e "\n${ECHO_SYM}-- ${ECHO_MSG}auto-package-update do this when emacs using.${ECHO_RST}"
fi

echo -e "\n${ECHO_SYM}* ${ECHO_MSG}update end ${ECHO_RST}\n"
echo -e "\n${ECHO_SYM}-- ${ECHO_MSG}Please do a check. Some action may failed, specially what need to being built at local, such as gentoo.${ECHO_RST}"

cd $current_dir

unset ECHO_SYM
unset ECHO_MSG
unset ECHO_RST
unset current_dir
# Define in function.sh, but subshell cannot using parent's shell's function.
echo $(($(date +%s) / 60 / 60 / 24)) >! $SHELL_CUSTOM_DIR/local/.update_epoch
