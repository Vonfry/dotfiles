source $HOME/.config/shell/defvar.sh
source ~/.local/src/antigen/antigen.zsh
antigen init ~/.antigenrc

# User configuration

setopt nonomatch
setopt extendedglob
setopt rm_star_silent
setopt clobber

if [[ ! $PATH =~ "/usr/local/bin"  ]]; then
    export PATH=/usr/local/bin:$PATH
fi

source $SHELL_CUSTOM_DIR/unalias.sh
source $SHELL_CUSTOM_DIR/alias.sh
source $SHELL_CUSTOM_DIR/function.sh
source $SHELL_CUSTOM_DIR/os.sh

export PATH=$HOME/.local/bin:$PATH

for file in $SHELL_CUSTOM_DIR/misc/*.zsh; do
    if [ -f $file ]; then
        source $file
    fi
done
for file in $SHELL_CUSTOM_DIR/misc/*.sh; do
    if [ -f $file ]; then
        source $file
    fi
done
for file in $SHELL_CUSTOM_DIR/local/*.zsh; do
    if [ -f $file ]; then
        source $file
    fi
done
for file in $SHELL_CUSTOM_DIR/local/*.sh; do
    if [ -f $file ]; then
        source $file
    fi
done

source $SHELL_CUSTOM_DIR/update.sh
