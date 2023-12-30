;;; embark/packages.el --- -*- lexical-binding: t -*-
;;

(use-package embark
  :custom
  (prefix-help-command 'embark-prefix-help-command)
  :general
  ("C-&" 'embark-act
   "C-%" 'embark-dwim))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))
