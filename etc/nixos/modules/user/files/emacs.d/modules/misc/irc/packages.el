;;; irc packages -*- lexical-binding: t -*-
;;

(use-package erc
  :init
  (load +irc-local-file t t)
  :custom
  (erc-log-channel-directory (expand-file-name "erc/log" vonfry-local-dir))
  (erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "NICK" "PART" "QUIT"))
  (erc-lurker-threshold-time 600)
  :general
  (nmap-at
    "i"   'erc-switch-to-buffer
    "I"   '(:ignore t :which-key "irc")
    "I i" '+irc/connect
    "I I" 'erc-tls
    "I l" 'erc-log-enable
    "I e" 'erc))
