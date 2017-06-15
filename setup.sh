#!/bin/bash

function echo_sh { print "\e[31m $@"; }

export script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export dropbox_dir="$HOME/Dropbox/Backup/dotfiles"
echo_sh "dir: $script_dir"
echo_sh "System: $(uname)"

mkdir ~/.cache

# bash $script_dir/setup/zsh.sh
# put this into system setup.
source $script_dir/setup/macos.sh
source $script_dir/setup/fedora.sh
source $script_dir/setup/pip.sh
source $script_dir/setup/gem.sh
source $script_dir/setup/npm.sh
source $script_dir/setup/go.sh
source $script_dir/setup/quicklisp.sh
source $script_dir/setup/cabal.sh
source $script_dir/setup/vim.sh
source $script_dir/setup/emacs.sh
source $script_dir/setup/git.sh
source $script_dir/setup/ln.sh
source $script_dir/setup/zsh.sh

echo "export CMD_CUSTOM_DIR=$HOME/.cmd-custom" >> ~/.cmd-custom/defvar.sh
echo "export DOTFILES_SOURCE_DIR=$script_dir" >> ~/.cmd-custom/defvar.sh
echo "export DOTFILES_DIR=$HOME/dotfiles" >> ~/.cmd-custom/defvar.sh
echo "export DROPBOX_DIR=$dropbox_dir" >> ~/.cmd-custom/defvar.sh


# alert
echo "
========
This setup has been done. But there are something not installed.
\`Docker\` on mac show be installed with docker-tool-box.
Any applications were not been initialized., such as \`mysql\`, \`postgresql\` and so on.
========
END
"

# unset var and function
unset -f echo_sh
unset script_dir
unset dropbox_dir
