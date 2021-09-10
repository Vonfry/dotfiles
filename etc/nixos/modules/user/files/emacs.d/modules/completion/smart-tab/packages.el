;;; smart-tab packages -*- lexical-binding: t -*-
;;

(use-package smart-tab
  :custom
  (smart-tab-user-provided-completion-function 'completion-at-point)
  :config
  (global-smart-tab-mode 1))
