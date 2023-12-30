;;; marginalia/packages.el --- -*- lexical-binding: t -*-
;;

(use-package marginalia
  :general
  ("M-A" 'marginalia-cycle)
  (:keymapsmap 'minibuffer-local-map
   "M-A" 'marginalia-cycle)
  :config
  (marginalia-mode))
