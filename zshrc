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

find -E $CMD_CUSTOM_DIR/misc -type f -regex '.*\.z?sh' | parallel source
find -E $CMD_CUSTOM_DIR/local -type f -regex '.*\.z?sh' | parallel source

# source $CMD_CUSTOM_DIR/update.sh
