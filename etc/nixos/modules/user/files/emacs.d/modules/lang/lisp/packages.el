;;; lisp/packages.el --- -*- lexical-binding: t -*-
;;

(use-package eldoc
  :ensure nil
  :hook
  ((emacs-lisp-mode lisp-interaction-mode ielm-mode) . turn-on-eldoc-mode))

(use-package ielm :ensure nil
  :custom
  (ielm-history-file-name (expand-file-name "ielm-history.eld" vonfry-cache-dir))
  :general
  (nmap-leader :keymaps '(emacs-lisp-mode-map lisp-interaction-mode-map)
    "\""    'ielm
    "RET"   'eval-last-sexp
    "' b"   'eval-buffer
    "' f"   'eval-defun)
  (nmap-leader
    "e '"   'eval-expression)
  (vmap-leader :keymaps 'emacs-lisp-mode-map
    "RET"   'eval-region
    "' RET" 'eval-region))

(add-hook 'elisp-mode-hook
          (lambda ()
            (vonfry/local-indent 2)))

(use-package sly
  :custom
  (inferior-lisp-program "sbcl")
  :general
  (nmap-leader :keymaps 'lisp-mode-map
    "' b"   'sly-eval-buffer
    "' f"   'sly-eval-defun
    "' RET" 'sly-eval-last-expression
    "RET"   'sly-eval-last-expression
    "\""    'sly
    "' \""  'sly-connect
    "?"     'sly-documentation)
  (nmap-mode :keymaps 'lisp-mode-map
    "RET"   'sly-inspect
    "?"     'sly-documentation-lookup)
  (vmap-leader :keymaps 'lisp-mode-map
    "RET"     'sly-eval-region
    "' RET"   'sly-eval-region))
