;;; embark packages -*- lexical-binding: t -*-
;;

(use-package embark
  :custom
  (prefix-help-command 'embark-prefix-help-command)
  :general
  ("M-o" 'embark-act
   "M-O" 'embark-dwim))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))
