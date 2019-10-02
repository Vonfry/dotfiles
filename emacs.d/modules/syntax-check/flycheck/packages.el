;;; flycheck packages -*- lexical-binding: t -*-
;;

(package! flycheck
  :hook (prog-mode . flycheck-mode)
  :custom
  (flycheck-global-modes nil)
  :general
  (nmap :keymaps 'prog-mode-map
        :prefix +nmap-leader
        +nmap-check 'flycheck-list-errors))

