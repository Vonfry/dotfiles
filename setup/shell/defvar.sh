echo_info "** defvar"
sed -i "s:<shell-custom-dir>:$HOME/.config/shell"           $config_defvar_file
sed -i "s:<shell-custom-dir-local>:$SHELL_CUSTOM_DIR/local" $config_defvar_file
sed -i "s:<dotfiles-source-dir>:$script_dir"                $config_defvar_file
sed -i "s:<dotfiles-dir>:$HOME/dotfiles"                    $config_defvar_file
sed -i "s:<dotfiles-pkgs-dir>:$script_dir/config/pkgs"      $config_defvar_file
sed -i "s:<zplug-home>:$HOME/.local/src/zplug"              $config_defvar_file
sed -i "s:<clouddisk-dir>:$clouddisk_dir"                   $config_defvar_file
sed -i "s:<update-interval>:7"                              $config_defvar_file
