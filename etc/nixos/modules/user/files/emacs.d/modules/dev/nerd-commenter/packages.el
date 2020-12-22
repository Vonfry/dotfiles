;;; nerd-commenter packages -*- lexical-binding: t -*-
;;

(package! evil-nerd-commenter
  :after evil
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "c"   '(:ignore t :which-key "nerd-commenter")
    "c i" 'evilnc-comment-or-uncomment-lines
    "c l" 'evilnc-quick-comment-or-uncomment-to-the-line
    "c c" 'evilnc-copy-and-comment-lines
    "c p" 'evilnc-comment-or-uncomment-paragraphs
    "c r" 'comment-or-uncomment-region
    "c v" 'evilnc-toggle-invert-comment-line-by-line
    "c ." 'evilnc-copy-and-comment-operator
    "c /" 'evilnc-comment-operator))
