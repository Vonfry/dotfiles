echo -e "\n${ECHO_SYM}** ${ECHO_MSG}nixos${ECHO_RST}"
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}update custom packages${ECHO_RST}\n"
cd /etc/nixos/user/vonfry/packages/custom/dev-lang/ruby
rm Gemfile.lock  gemset.nix
bundix -l
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}rebuild${ECHO_RST}\n"
sudo nixos-rebuild switch --upgrade
