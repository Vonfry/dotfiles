#!/bin/bash

function echo_sh { print "\e[31m $@"; }

export script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export dropbox_dir="~/Dropbox/Backup/dotfiles"
echo_sh "dir: $script_dir"
echo_sh "System: $(uname)"

bash $script_dir/setup/macos.sh
bash $script_dir/setup/linux.sh
bash $script_dir/setup/pip.sh
bash $script_dir/setup/gem.sh
bash $script_dir/setup/npm.sh
bash $script_dir/setup/go.sh
bash $script_dir/setup/quicklisp.sh
bash $script_dir/setup/cabal.sh
bash $script_dir/setup/zsh.sh
bash $script_dir/setup/vim.sh
bash $script_dir/setup/emacs.sh
bash $script_dir/setup/git.sh

# copy other dotfiles
echo_sh "** copy other dotfiles"
ln -f -s $script_dir/ackrc ~/.ackrc
mkdir ~/.config
ln -f -s $script_dir/config/* ~/.config/
mkdir ~/.ssh
ln -f -s $dropbox_dir/ssh/vonfry/* ~/.ssh/
ln -f -s $script_dir/ghci ~/.ghci
ln -f -s $script_dir/rtorrent.rc ~/.rtorrent.rc

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
