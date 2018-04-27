set ECHO_SYM "\033[0;31m"
set ECHO_MSG "\033[0;36m"
set ECHO_RST "\033[0m"
function vonfry-update
    set ECHO_SYM "\033[0;31m"
    set ECHO_MSG "\033[0;36m"
    set ECHO_RST "\033[0m"

    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"update start"$ECHO_RST"\n"

    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"dotfiles"$ECHO_RST"\n"
    cd $DOTFILES_DIR
    git pull
    cd -

    switch (uname)
        case "Darwin"
            echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"system: "(uname){$ECHO_RST}"\n"
            echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"homebrew"$ECHO_RST"\n"
            brew update
            brew upgrade
            brew cask upgrade
            brew cleanup
            echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"app store"$ECHO_RST"\n"
            sudo softwareupdate --install --all
        # if ctags is updated, emacs needs being recompiled.
        case "Linux"
            source /etc/os-release
            echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"system: "{$ID}{$ECHO_RST"}\n"
            switch "$ID"
                case "fedora"
                    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"dnf"$ECHO_RST"\n"
                    sudo dnf clean all
                    sudo dnf update -y
                    sudo dnf clean all
                case "gentoo"
                    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"portage"$ECHO_RST"\n"
                    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"sync portage and custom repos"$ECHO_RST"\n"
                    sudo eix-sync -q # This action contains portage/layman sync.
                    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"portage self"$ECHO_RST"\n"
                    sudo emerge --oneshot --quiet portage
                    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"layman"$ECHO_RST"\n"
                    sudo haskell-updater --quiet
                    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"portage worlds"$ECHO_RST"\n"
                    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"If use flag has been changed, run emerge with --newuse or --changed-use. This updating dosen't contain them."$ECHO_RST"\n"
                    sudo emerge --quiet --update --deep --with-bdeps=y @world
                    sudo emerge --depclean --quiet
            end
    end

    echo "You may run /usr/local/opt/fzf/install to install fzf"

    if command -v fisher >/dev/null 2>&1; then
        echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"zplug"$ECHO_RST"\n"
        fisher update
    end
    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"haskell"$ECHO_RST"\n"
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"cabal"$ECHO_RST"\n"
    cabal update --verbose=1
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"stack"$ECHO_RST"\n"
    stack update --silent
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"hoogle"$ECHO_RST"\n"
    hoogle generate --quiet
    echo -e "\n"$ECHO_MSG"All things with haskell are only updated with indexed file, please update each package by yourself."
    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"python"$ECHO_RST"\n"
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"pip3"$ECHO_RST"\n"
    if test (uname) = Darwin
        pip3 install --quiet --upgrade pip setuptools wheel
        pip3 install --quiet --upgrade -r $DOTFILES_DIR/config/pkgs/pip3.txt
    else
        pip3 install --quiet --user --upgrade pip setuptools wheel
        pip3 install --quiet --user --upgrade -r $DOTFILES_DIR/config/pkgs/pip3.txt
    end
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"pip2"$ECHO_RST"\n"
    if test (uname) = Darwin
        pip2 install --quiet --upgrade pip setuptools wheel
        pip2 install --quiet --upgrade -r $DOTFILES_DIR/config/pkgs/pip2.txt
    else
        pip2 install --user --upgrade pip setuptools wheel
        pip2 install --user --upgrade -r $DOTFILES_DIR/config/pkgs/pip2.txt
    end
    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"ruby"$ECHO_RST"\n"
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"gem"$ECHO_RST"\n"
    gem update --silent; and gem update --system --silent
    gem cleanup
    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"npm"$ECHO_RST"\n"
    if test (uname) = Linux
        sudo npm update -g --silent
    else
        npm update -g --silent
    end

    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"R"$ECHO_RST"\n"
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"packages"$ECHO_RST"\n"
    R --slave --quiet -e "update.packages(ask = FALSE, quiet = TRUE)"

    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"vim"$ECHO_RST"\n"
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"vundle"$ECHO_RST"\n"
    vim -c "execute \"PluginUpdate\" | qa"
    echo -e "\n"$ECHO_SYM"** "$ECHO_MSG"ycm"$ECHO_RST"\n"
    python3 ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer --system-boost --system-libclang --quiet
    cd ~/.vim/bundle/vimproc.vim/; and make; and  cd -

    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"Emacs"$ECHO_RST"\n"
    echo -e "\n"$ECHO_SYM"-- "$ECHO_MSG"Emacs will be killed."$ECHO_RST
    killall emacs
    emacs --batch --load $DOTFILES_DIR/emacs.d/init.el --eval "(package-refresh-contents)" --eval "(vonfry/update-all-packages)"
    set -U whether_do_kill

    echo -e "\n"$ECHO_SYM"* "$ECHO_MSG"update end "$ECHO_RST"\n"

    set -U ECHO_SYM
    set -U ECHO_MSG
    set -U ECHO_RST
    echo (_current_epoch) > $CMD_CUSTOM_DIR/local/.update_epoch
end

set update_epoch_file $CMD_CUSTOM_DIR/local/.update_epoch
set need_update false
if test -f $update_epoch_file
    cat $update_epoch_file | read last_update
    set during_last_update (math (_current_epoch) - $last_update)
    if test $during_last_update -ge 7
       set need_update true
    end
    set -U during_last_update
    set -U last_update
end
if eval $need_update
    echo -e "\n"$ECHO_SYM"[vonfry]"$ECHO_MSG" Would you like to check for updates? [Y/n]:"$ECHO_RST"\c"
    read whether_do_update
    if test $whether_do_update = y; or test $whether_do_update = Y; or test -z $whether_do_update
        vonfry-update
    end
    set -U whether_do_update
end
set -U update_epoch_file
set -U need_update
set -U ECHO_SYM
set -U ECHO_MSG
set -U ECHO_RST
