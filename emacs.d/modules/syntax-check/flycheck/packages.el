;;; flycheck packages -*- lexical-binding: t -*-
;;

(package! flycheck
  :hook (prog-mode . flycheck-mode)
  :custom
  (flycheck-global-modes nil)
  :general
  (+mmap-leader-def
    :keymaps 'prog-mode-map
    "q" 'flycheck-list-errors))

