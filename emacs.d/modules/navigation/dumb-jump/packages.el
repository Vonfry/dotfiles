;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(package! dumb-jump
  :general
  (+nmap-leader-def
    :keymaps 'prog-mode-map
    "."   'dumb-jump-go
    ","   'dumb-jump-back
    "&"   'dumb-jump-quick-look
    "["   'dumb-jump-go-prompt)
    ">"   '(nil :which-key "dumb-jump")
    "> ." 'dumb-jump-go
    "> ," 'dumb-jump-back
    "> [" 'dumb-jump-go-prompt
    "> ;" 'dumb-jump-go-other-window
    "> >" 'dumb-jump-quick-look
    "> <" 'dumb-jump-go-prefer-external
    "> :" 'dumb-jump-go-prefer-external-other-window)
  :custom
  (dumb-jump-selector 'ivy))
