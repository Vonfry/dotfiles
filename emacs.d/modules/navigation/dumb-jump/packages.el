;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(package! dumb-jump
  :general
  (nmap :prefix +nmap-leader
        +nmap-go-prompt 'dumb-jump-go-prompt)
  (nmap :prefix +dumb-jump-nmap-prefix
        +nmap-go            'dumb-jump-go
        +nmap-go-back       'dumb-jump-back
        +nmap-go-prompt     'dumb-jump-go-prompt
        "o" 'dumb-jump-go-other-window
        ">" 'dumb-jump-quick-look
        "<" 'dumb-jump-go-prefer-external
        ":" 'dumb-jump-go-prefer-external-other-window)
  :custom
  (dumb-jump-selector 'ivy))
