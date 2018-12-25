;;; nerd-commenter packages -*- lexical-binding: t -*-
;;

(package! evil-nerd-commenter
  :after evil
  :config
  (evilnc-default-hotkeys t)
  :general
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-nc-prefix
        ""  '(nil :which-key "nerd-commenter")
        "i" 'evilnc-comment-or-uncomment-lines
        "l" 'evilnc-quick-comment-or-uncomment-to-the-line
        "c" 'evilnc-copy-and-comment-lines
        "p" 'evilnc-comment-or-uncomment-paragraphs
        "r" 'comment-or-uncomment-region
        "v" 'evilnc-toggle-invert-comment-line-by-line
        "." 'evilnc-copy-and-comment-operator
        "/" 'evilnc-comment-operator))
