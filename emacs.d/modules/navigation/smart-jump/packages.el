;;; smart-jump packages -*- lexical-binding: t -*-
;;

(package! smart-jump
  :after dumb-jump
  :config
  (smart-jump-register :modes 'ess-mode) ; use xref
  (smart-jump-setup-default-registers)
  :general
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-leader
        +nmap-go           'smart-jump-go
        +nmap-go-back      'smart-jump-back
        +nmap-go-peek      'smart-jump-peek
        +nmap-go-reference 'smart-jump-references))

