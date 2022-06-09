;;; nerd-commenter packages -*- lexical-binding: t -*-
;;

(use-package evil-nerd-commenter
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "c i"  'evilnc-comment-or-uncomment-lines
    "c l"  'evilnc-quick-comment-or-uncomment-to-the-line
    "c c"  'evilnc-copy-and-comment-lines
    "c p"  'evilnc-comment-or-uncomment-paragraphs
    "c v"  'evilnc-toggle-invert-comment-line-by-line
    "c ."  'evilnc-copy-and-comment-operator
    "c /"  'evilnc-comment-operator)
  (vmap-leader :keymaps 'prog-mode-map
    "c r" 'comment-or-uncomment-region))
