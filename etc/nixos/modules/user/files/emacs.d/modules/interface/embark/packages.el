;;; embark packages -*- lexical-binding: t -*-
;;

(use-package embark
  :custom
  (prefix-help-command 'embark-prefix-help-command)
  :general
  ("C-[" 'embark-act)
  ("C-{" 'embark-dwim)
  ("C-h B" 'embark-bindings))
