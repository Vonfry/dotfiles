echo_info "** defvar"
sed -i "s:<dotfiles-source-dir>:$script_dir"                $config_defvar_file
sed -i "s:<clouddisk-dir>:$clouddisk_dir"                   $config_defvar_file
sed -i "s:<cloudremote-dir>:$cloudremote_dir"               $config_defvar_file
