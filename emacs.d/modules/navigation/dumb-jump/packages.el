;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(package! dumb-jump
  :general
  (nmap :prefix +nmap-leader
        +nmap-go        'dumb-jump-go
        +nmap-go-back   'dumb-jump-back
        +nmap-go-peek   'dumb-jump-quick-look
        +nmap-go-prompt 'dumb-jump-go-prompt)
  (nmap :prefix +dumb-jump-nmap-prefix
        :keymaps 'prog-mode-map
        "" '(nil :which-key "dumb-jump")
        +nmap-go        'dumb-jump-go
        +nmap-go-back   'dumb-jump-back
        +nmap-go-prompt 'dumb-jump-go-prompt
        +nmap-go-peek   'dumb-jump-go-other-window
        ">" 'dumb-jump-quick-look
        "<" 'dumb-jump-go-prefer-external
        ":" 'dumb-jump-go-prefer-external-other-window)
  :custom
  (dumb-jump-selector 'ivy))
