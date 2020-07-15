;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

;; +mmap-elisp-def
(mmap-leader-prefix! elisp nil
  :keymaps 'emacs-lisp-mode-map)

(package! ielm :ensure nil
  :general
  (+mmap-elisp-def
    "\""  'ielm
    "' b" 'eval-buffer
    "' r" 'eval-region))

(hook! elisp-mode (vonfry/local-indent 2))
