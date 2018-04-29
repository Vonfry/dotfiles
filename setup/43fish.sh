ln -s -f $script_dir/config/fish/config.fish ~/.config/fish/config.fish

echo "set -x CMD_CUSTOM_DIR $HOME/.cmd-custom"             >> $script_dir/cmd-custom/defvar.fish
echo "set -x CMD_CUSTOM_DIR_LOCAL $HOME/.cmd-custom/local" >> $script_dir/cmd-custom/defvar.fish
echo "set -x DOTFILES_SOURCE_DIR $script_dir"              >> $script_dir/cmd-custom/defvar.fish
echo "set -x DOTFILES_DIR $HOME/dotfiles"                  >> $script_dir/cmd-custom/defvar.fish
echo "set -x DOTFILES_PKGS_DIR $script_dir/config/pkgs"    >> $script_dir/cmd-custom/defvar.fish
echo "set -x DROPBOX_DIR $dropbox_dir"                     >> $script_dir/cmd-custom/defvar.fish

fisher install oh-my-fish/theme-agnoster
fisher install gitignore
fisher install autojump
fisher install joseluisq/gitnow
fisher install fzf
fisher install edc/bass
fisher install oh-my-fish/plugin-git-flow
