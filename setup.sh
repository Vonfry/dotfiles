#!/bin/bash

function echo_warn() { echo -e "\n\033[0;31m $@\n"; echo -e "\033[0m" }
function echo_info() { echo -e "\n\033[0;36m $@\n"; echo -e "\033[0m" }
function echo_note() { echo -e "\n\033[0m $@\n";    echo -e "\033[0m" }

export script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export dropbox_dir="$HOME/Dropbox/Backup/dotfiles"
echo_sh "dir: $script_dir"
echo_sh "System: $(uname)"

mkdir ~/.cache

# bash $script_dir/setup/zsh.sh
# put this into system setup.
source $script_dir/setup/os.sh
source $script_dir/setup/pkgs.sh
source $script_dir/setup/vim.sh
source $script_dir/setup/emacs.sh
source $script_dir/setup/git.sh
source $script_dir/setup/ln.sh
source $script_dir/setup/zsh.sh
source $script_dir/setup/shell.sh

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
