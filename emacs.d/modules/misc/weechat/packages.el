;;; weechat packages -*- lexical-binding: t -*-
;;

(package! weechat
  :custom
  (weechat-mode-default 'ssl)
  :config
  (if +weechat-local-config-file
    (load +weechat-local-config-file t t)
    nil))
