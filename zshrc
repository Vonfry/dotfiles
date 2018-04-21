source $HOME/.cmd-custom/defvar.sh
source ~/.local/antigen/antigen.zsh
antigen init ~/.antigenrc

# User configuration

setopt nonomatch
setopt extendedglob
setopt rm_star_silent

export PATH=/usr/local/bin:$PATH

source $CMD_CUSTOM_DIR/unalias.sh
source $CMD_CUSTOM_DIR/alias.sh
source $CMD_CUSTOM_DIR/os.sh
source $CMD_CUSTOM_DIR/function.sh

export PATH=$HOME/.local/bin:$HOME/.cabal/bin:$PATH

for file in $CMD_CUSTOM_DIR/misc/*; do
    if [ -f $file ]; then
        source $file
    fi
done
for file in $CMD_CUSTOM_DIR/local/*; do
    if [ -f $file ]; then
        source $file
    fi
done

# source $CMD_CUSTOM_DIR/update.sh
