;;; fold/packages.el --- -*- lexical-binding: t -*-

(use-package hideshow
  :ensure nil
  :hook ((lisp-mode elisp-mode latex-mode bibtex-mode) . hs-minor-mode))
