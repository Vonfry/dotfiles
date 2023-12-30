;;; nerd-commenter/packages.el --- -*- lexical-binding: t -*-
;;

(use-package evil-nerd-commenter
  :after evil
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "c i" 'evilnc-comment-or-uncomment-lines
    "c l" 'evilnc-quick-comment-or-uncomment-to-the-line
    "c c" 'evilnc-copy-and-comment-lines
    "c p" 'evilnc-comment-or-uncomment-paragraphs
    "c s" 'evilnc-comment-box
    "c r" 'comment-or-uncomment-region
    "c v" 'evilnc-toggle-invert-comment-line-by-line
    "c ." 'evilnc-copy-and-comment-operator
    "c ," 'evilnc-comment-operator)
  (:keymaps 'evil-inner-text-objects-map
             evilnc-comment-text-object
             'evilnc-inner-commenter)
  (:keymaps 'evil-outer-text-objects-map
             evilnc-comment-text-object
             'evilnc-outer-commenter)
  (vmap-leader :keymaps 'prog-mode-map
    "c i" 'evilnc-comment-or-uncomment-lines
    "c c" 'evilnc-copy-and-comment-lines
    "c s" 'evilnc-comment-box
    "c r" 'comment-or-uncomment-region
    "c ." 'evilnc-copy-and-comment-operator
    "c ," 'evilnc-comment-operator))
