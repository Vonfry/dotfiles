;;; irc packages -*- lexical-binding: t -*-
;;

(package! erc
  :config
  ;(add-to-list 'erc-sasl-server-regexp-list "chat\\.freenode\\.net")
  (load +irc-local-file t t)
  :custom
  (erc-log-channel-directory (expand-file-name "erc/log"))
  (erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
  :general
  (+mmap-at-def
    "i"   '(nil :which-key "irc")
    "i i" '+irc/connect
    "i b" 'erc-switch-to-buffer
    "i I" 'erc-tls
    "i l" 'erc-log-enable
    "i e" 'erc))
