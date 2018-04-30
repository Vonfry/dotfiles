source $HOME/.cmd-custom/defvar.fish
set -x PATH /usr/local/bin $PATH

# User configuration

source $CMD_CUSTOM_DIR/unalias.fish
source $CMD_CUSTOM_DIR/alias.fish
source $CMD_CUSTOM_DIR/os.fish
source $CMD_CUSTOM_DIR/function.fish

set -x PATH $HOME/.local/bin $PATH

for file in $CMD_CUSTOM_DIR/misc/*.fish
    if test -f $file
        source $file
    end
end
for file in $CMD_CUSTOM_DIR/local/*.fish
    if test -f $file
        source $file
    end
end

source $CMD_CUSTOM_DIR/update.fish
