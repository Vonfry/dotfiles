;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(use-package dumb-jump
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "."   'xref-find-definitions
    ","   'xref-pop-marker-stack
    "&"   'xref-find-apropos
    "{"   'xref-find-references
    "> &" 'xref-find-apropos)
  :config
  (add-hook 'xref-backend-functions  'dumb-jump-xref-activate)
  :custom
  (dumb-jump-selector 'completing-read))
