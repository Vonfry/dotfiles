;;; flycheck packages -*- lexical-binding: t -*-
;;

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :custom
  (flycheck-global-modes nil)
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "Q"   '(nil :which-key "flycheck")
    "Q Q" 'flycheck-explain-error-at-point
    "Q q" 'flycheck-list-errors))

