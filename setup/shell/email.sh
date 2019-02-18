echo_info "** set mutt"

ln -sf $script_dir/muttrc ~/.muttrc
mkdir ~/.mutt 2> /dev/null
ln -sf $dropbox_dir/mutt/vonfry ~/.mutt/vonfry

echo "--- Email client(mutt) config: please edit ~/.muttrc by yourself."
