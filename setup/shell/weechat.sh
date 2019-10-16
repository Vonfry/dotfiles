echo_info "** weechat"
weechat -r "/set irc.look.smart_filter on"
weechat -r "/set irc.look.smart_filter_delay 5"
weechat -r "/filter add irc_smart * irc_smart_filter *"
weechat -r "/server add freenode chat.freenode.net"
weechat -r "/set irc.server.freenode.sasl_mechanism ecdsa-nist256p-challenge"
echo_note "--- input weechat username: "
read weechat_username
weechat -r "/set irc.server.freenode.sasl_username \"$weechat_username\""
weechat -r "/set irc.server.freenode.sasl_key \"%h/certs/ecdsa.pem\""
unset weechat_username
