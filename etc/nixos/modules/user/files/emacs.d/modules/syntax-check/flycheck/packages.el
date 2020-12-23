;;; flycheck packages -*- lexical-binding: t -*-
;;

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :custom
  (flycheck-global-modes nil)
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "q" 'flycheck-list-errors))

