source ~/.zplug/init.zsh

source $DOTFILES_DIR/cmd-custom/zplug.default.zsh
find . -name "zplug.local.*" | xargs -P 8 -n1 source

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load >> /dev/null 2>&1
