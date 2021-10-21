;;; smart-tab packages -*- lexical-binding: t -*-
;;

(use-package smart-tab
  :custom
  (smart-tab-user-provided-completion-function 'completion-at-point)
  (smart-tab-disabled-major-modes '(org-mode term-mode eshell-mode eww-mode
                                    magit-mode telega-chat-mode))
  :config
  (global-smart-tab-mode 1))
