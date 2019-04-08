if [ -n "${BASH}" ]; then
    shell="bash"
elif [ -n "${ZSH_NAME}" ]; then
    shell="zsh"
elif [ -n "${__fish_datadir}" ]; then
    shell="fish"
elif [ -n "${version}" ]; then
    shell="tcsh"
else
    shell=$(echo ${SHELL} | awk -F/ '{ print $NF }')
fi
if  command -v autojump > /dev/null 2>&1; then
    source $(nix-store -q $(nix-store -qd $(which autojump)))/share/autojump/autojump.$shell
fi
unset shell
