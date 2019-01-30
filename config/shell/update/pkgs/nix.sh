echo -e "\n${ECHO_SYM}* ${ECHO_MSG}nix${ECHO_RST}"
if command -v nix-env >/dev/null 2>&1 &&
    [[ ! (-f /etc/os-release && $(cat /etc/os-release) =~ "nixos") ]]; then
    nix-channel --update
    nix-env -u
fi
