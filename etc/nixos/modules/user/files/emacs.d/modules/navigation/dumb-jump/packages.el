;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(use-package dumb-jump
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "."   'xref-goto-xref
    ","   'xref-pop-marker-stack
    "&"   'xref-find-apropos
    "("   'xref-find-definitions
    "{"   'xref-find-references
    "?"   'info-xref
    "> ?" 'info-xref-docstrings)
  :config
  (add-hook 'xref-backend-functions  'dumb-jump-xref-activate)
  :custom
  (dumb-jump-selector 'ivy))
