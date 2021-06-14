;;; im packages -*- lexical-binding: t -*-
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

(use-package telega
  :custom
  (telega-directory (expand-file-name "telega" vonfry-cache-dir))
  (telega-database-dir (expand-file-name "telega" vonfry-local-dir))
  (telega-open-file-function 'org-open-file)
  :hook
  (telega-load-hook . telega-notifications-mode)
  :general
  (nmap-at
    "t" telega-prefix-map))
