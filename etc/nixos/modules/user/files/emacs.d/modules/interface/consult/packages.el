;;; consult packages -*- lexical-binding: t -*-
;;

(use-package consult
  :custom
  (xref-show-xrefs-function 'consult-xref)
  (xref-show-definitions-function 'consult-xref)
  (register-preview-delay 0.5)
  (register-preview-function 'consult-register-format)
  :general
  (:keymaps 'isearch-mode-map
   "M-e" 'consult-isearch-history
   "M-s e" 'consult-isearch-history
   "M-s l" 'consult-line
   "M-s L" 'consult-line-multi
   :keymapsmap 'minibuffer-local-map
   "M-s" 'consult-history
   "M-r" 'consult-history)
  (nmap-leader
    "f" 'consult-find
    "p" 'consult-locate
    "F" '(:ignore t :which-key "completion misc")
    "F r" 'consult-recentf
    "F h "'consult-history
    "F ?" 'consult-man
    "q"   'consult-flycheck
    "a"   'consult-ripgrep
    "b"   'consult-buffer
    "<"   'consult-mark
    "?"   'consult-apropos
    "y"   'consult-yank-pop
    "m"   'consult-bookmark
    ";"   'consult-imenu
    ":"   'consult-imenu-multi
    "/"   'consult-line)
  (nmap-leader :keymaps 'outline-mode-map
    ";" 'consult-outline)
  (nmap-mode :keymaps 'org-mode-map
    ";" 'consult-org-heading))
