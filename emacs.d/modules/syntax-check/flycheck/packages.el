;;; flycheck packages -*- lexical-binding: t -*-
;;

(package! flycheck
  :hook (prog-mode . flycheck-mode)
  :custom
  (flycheck-global-modes nil))

