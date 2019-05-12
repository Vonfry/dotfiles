echo -e "\n${ECHO_SYM}** ${ECHO_MSG}nixos${ECHO_RST}"
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}update custom packages${ECHO_RST}\n"
custom_ruby_path=/etc/nixos/user/vonfry/packages/custom/dev-ruby/self-pkgs
sudo rm $custom_ruby_path/Gemfile.lock  $custom_ruby_path/gemset.nix
sudo sh -c "cd $custom_ruby_path; bundle lock"
sudo sh -c "cd $custom_ruby_path; bundix -l"
unset custom_ruby_path
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}channel${ECHO_RST}\n"
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}unstable${ECHO_RST}\n"
sudo nix-channel --update nixos-unstable
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}rebuild${ECHO_RST}\n"
sudo nixos-rebuild switch --upgrade
