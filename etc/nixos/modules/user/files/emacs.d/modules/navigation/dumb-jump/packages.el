;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(use-package dumb-jump
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "."   'xref-find-definitions
    ","   'xref-go-back
    "<"   'xref-go-forward
    "&"   'xref-find-apropos
    "{"   'xref-find-references
    "> &" 'xref-find-apropos
    "> ." 'xref-find-definitions-other-window
    "> ," 'xref-find-definitions-other-frame
    "> {" 'xref-find-references-and-replace)
  :config
  (add-hook 'xref-backend-functions  'dumb-jump-xref-activate)
  :custom
  (dumb-jump-selector 'completing-read))
