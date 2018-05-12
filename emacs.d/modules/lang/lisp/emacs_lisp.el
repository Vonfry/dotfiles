;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

(package! ielm :ensure nil
  :hook (ielm-mode . company-mode))
