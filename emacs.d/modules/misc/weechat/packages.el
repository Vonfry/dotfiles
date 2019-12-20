;;; weechat packages -*- lexical-binding: t -*-
;;

(package! weechat
  :custom
  (weechat-mode-default 'ssl)
  (weechat-host-default "chat.freenode.org")
  (weechat-port-default 6697)
  :config
  (if +weechat-local-config-file
    (load +weechat-local-config-file t t)
    nil))
