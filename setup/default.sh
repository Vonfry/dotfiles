#!/bin/sh

function echo_warn() { echo -e "\n\033[0;31m $@\n"; echo -e "\033[0m" }
function echo_info() { echo -e "\n\033[0;36m $@\n"; echo -e "\033[0m" }
function echo_note() { echo -e "\n\033[0m $@\n";    echo -e "\033[0m" }

export current_dir=$(pwd)
export script_dir=$( cd "$( dirname "$0" )/.." && pwd )
export clouddisk_dir="$HOME/cloud"
echo_note "Input a path that where to save the third lib or tools needing to be built by youself."
read source_dir
export source_dir=$source_dir
echo_info "dir: $script_dir"
echo_info "System: $(uname)"

mkdir -p ~/.cache
mkdir -p ~/.local/bin

runscript="$SHELL"
$runscript $script_dir/setup/os/default.sh
$runscript $script_dir/setup/pkgs/default.sh
$runscript $script_dir/setup/editor/default.sh
$runscript $script_dir/setup/shell/default.sh
$runscript $script_dir/setup/x/default.sh

# alert
echo "
========
This setup has been done. But there are something not installed.
\`Docker\` on mac show be installed with docker-tool-box.
Any applications were not been initialized., such as \`mysql\`, \`postgresql\` and so on.
========\n
"

# unset var and function
unset -f echo_warn
unset -f echo_info
unset -f echo_note
unset script_dir
unset clouddisk_dir
unset source_dir
unset runscript

source $HOME/.zshrc
