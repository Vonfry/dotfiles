;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(package! dumb-jump
  :general
  (+mmap-dumb-def
    "."   'dumb-jump-go
    ","   'dumb-jump-back
    "&"   'dumb-jump-quick-look
    "["   'dumb-jump-go-prompt
    ">"   '(nil :which-key "dumb-jump")
    "> ." 'dumb-jump-go
    "> ," 'dumb-jump-back
    "> [" 'dumb-jump-go-prompt
    "> ;" 'dumb-jump-go-other-window
    "> >" 'dumb-jump-quick-look
    "> <" 'dumb-jump-go-prefer-external
    "> :" 'dumb-jump-go-prefer-external-other-window)
  :hook (prog-mode . dumb-jump-mode)
  :custom
  (dumb-jump-selector 'ivy))
