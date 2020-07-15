;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(package! dumb-jump
  :general
  (+mmap-prog-def
    "."   'dumb-jump-go
    ","   'dumb-jump-back
    ">"   'dumb-jump-quick-look
    "["   'dumb-jump-go-prompt
    "{"   'dumb-jump-go-other-window
    "}"   'dumb-jump-go-prefer-external
    "("   'dumb-jump-go-prefer-external-other-window)
  (+mmap-dumb-def
    "."   'dumb-jump-go
    ","   'dumb-jump-back
    ">"   'dumb-jump-quick-look
    "["   'dumb-jump-go-prompt
    "{"   'dumb-jump-go-other-window
    "}"   'dumb-jump-go-prefer-external
    "("   'dumb-jump-go-prefer-external-other-window)
  :hook (prog-mode . dumb-jump-mode)
  :custom
  (dumb-jump-selector 'ivy))
