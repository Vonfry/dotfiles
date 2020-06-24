echo -e "\n${ECHO_SYM}* ${ECHO_MSG}system: $(uname)${ECHO_RST}"
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}homebrew${ECHO_RST}\n"
brew update
brew upgrade
brew cask upgrade
brew cleanup
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}app store${ECHO_RST}\n"
sudo softwareupdate --install --all
echo -e "\n${ECHO_SYM}--- ${ECHO_MSG}You may run /usr/local/opt/fzf/install to install fzf${ECHO_RST}"
