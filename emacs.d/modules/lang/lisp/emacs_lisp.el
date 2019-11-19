;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

;; +nmap-elisp-def
(vonfry-def-nmap-leader-prefix elisp nil
  :keymaps 'emacs-lisp-mode-map)

(package! ielm :straight nil
  :general
  (+nmap-elisp-def
    "\""  'ielm
    "' b" 'eval-buffer
    "' r" 'eval-region))

