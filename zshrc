if [ ! -v VONFRY_SHELL ]; then
    source $HOME/.zshenv
fi

# User configuration

setopt nonomatch
setopt extendedglob
setopt rm_star_silent
setopt clobber

source $SHELL_CUSTOM_DIR/zplug.zsh
source $SHELL_CUSTOM_DIR/unalias.sh
source $SHELL_CUSTOM_DIR/alias.sh
source $SHELL_CUSTOM_DIR/function.sh
source $SHELL_CUSTOM_DIR/os.sh

export PATH=$HOME/.local/bin:$PATH

for file in $SHELL_CUSTOM_DIR/misc/*.zsh; do
    source $file
done
for file in $SHELL_CUSTOM_DIR/misc/*.sh; do
    source $file
done
for file in $SHELL_CUSTOM_DIR/misc.local/*.zsh; do
    source $file
done
for file in $SHELL_CUSTOM_DIR/misc.local/*.sh; do
    source $file
done

source $SHELL_CUSTOM_DIR/update.sh
