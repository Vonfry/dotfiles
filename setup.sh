#!/bin/bash

function echo_warn() { echo -e "\n\033[0;31m $@\n"; echo -e "\033[0m" }
function echo_info() { echo -e "\n\033[0;36m $@\n"; echo -e "\033[0m" }
function echo_note() { echo -e "\n\033[0m $@\n";    echo -e "\033[0m" }

export script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export dropbox_dir="$HOME/Dropbox/Backup/dotfiles"
echo_note "--- input a path that where to save the third lib or tools needing to be built by youself."
read source_dir
export source_dir=$source_dir
echo_sh "dir: $script_dir"
echo_sh "System: $(uname)"

mkdir -p ~/.cache > /dev/null 2>&1
mkdir -p ~/.local/bin > /dev/null 2>&1

# bash $script_dir/setup/zsh.sh
# put this into system setup.
bash $script_dir/setup/os.sh
bash $script_dir/setup/pkgs.sh
bash $script_dir/setup/vim.sh
bash $script_dir/setup/emacs.sh
bash $script_dir/setup/git.sh
bash $script_dir/setup/ln.sh
bash $script_dir/setup/zsh.sh
bash $script_dir/setup/shell.sh

# alert
echo "
========
This setup has been done. But there are something not installed.
\`Docker\` on mac show be installed with docker-tool-box.
Any applications were not been initialized., such as \`mysql\`, \`postgresql\` and so on.
========\n
"

# unset var and function
unset -f echo_sh
unset script_dir
unset dropbox_dir
unset source_dir

source $HOME/.zshrc
