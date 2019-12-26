if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
    source /usr/local/etc/profile.d/autojump.sh
elif [ "$ID" = nixos ]; then
    source $(nix-store --quiet --quiet -r $(which autojump))/share/autojump/autojump.$SHELL_NAME
fi
