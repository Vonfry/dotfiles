;;; serach/packages.el --- -*- lexical-binding: t -*-
;;

(use-package consult-omni
  :after (consult embark)
  :disabled
  :custom
  (consult-omni-sources-load-modules '())
  :config
  (require 'consult-omni-sources)
  (require 'consult-omni-embark)
  (consult-omni-sources-load-modules)
  :general
  (nmap-at "/" consult-omni))
