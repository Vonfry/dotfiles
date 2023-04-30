;;; consult packages -*- lexical-binding: t -*-
;;

(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :custom
  (completion-in-region-function #'consult-completion-in-region)
  (xref-show-xrefs-function 'consult-xref)
  (xref-show-definitions-function 'consult-xref)
  (register-preview-delay 0.5)
  (register-preview-function 'consult-register-format)
  :general
  (:keymaps 'isearch-mode-map
   "M-e" 'consult-isearch-history
   "M-s e" 'consult-isearch-history
   "M-s l" 'consult-line
   "M-s L" 'consult-line-multi)
  (:keymaps 'minibuffer-local-map
   "M-r" 'consult-history)
  (nmap-leader
    "p"   'consult-find
    "F r" 'consult-recent-file
    "F f" 'consult-find
    "F F" 'consult-file-externally
    "F p" 'consult-locate
    "F h "'consult-history
    "F ?" 'consult-man
    "a"   'consult-ripgrep
    "b"   'consult-buffer
    "<"   'consult-mark
    "?"   'consult-apropos
    "y"   'consult-yank-pop
    "m"   'consult-bookmark
    ";"   'consult-imenu
    ":"   'consult-imenu-multi
    "/"   'consult-line
    "q"   'consult-flymake)
  (nmap-leader :keymaps 'outline-mode-map
    ";" 'consult-outline)
  (nmap-mode :keymaps 'org-mode-map
    ";" 'consult-org-heading))
