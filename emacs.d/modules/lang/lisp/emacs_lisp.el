;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

;; +mmap-elisp-def
(vonfry-def-mmap-leader-prefix elisp nil
  :keymaps 'emacs-lisp-mode-map)

(package! ielm :ensure nil
  :general
  (+mmap-elisp-def
    "\""  'ielm
    "' b" 'eval-buffer
    "' r" 'eval-region))

