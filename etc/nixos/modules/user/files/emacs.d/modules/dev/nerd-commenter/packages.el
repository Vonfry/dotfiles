;;; nerd-commenter packages -*- lexical-binding: t -*-
;;

(use-package evil-nerd-commenter
  :general
  (nmap-leader :infix "c" :keymaps 'prog-mode-map
    ""   '(:ignore t :which-key "nerd-commenter")
    "i"  'evilnc-comment-or-uncomment-lines
    "l"  'evilnc-quick-comment-or-uncomment-to-the-line
    "c"  'evilnc-copy-and-comment-lines
    "p"  'evilnc-comment-or-uncomment-paragraphs
    "v"  'evilnc-toggle-invert-comment-line-by-line
    "."  'evilnc-copy-and-comment-operator
    "/"  'evilnc-comment-operator)
  (vmap-leader :infix "c" :keymaps 'prog-mode-map
    "r" 'comment-or-uncomment-region))
