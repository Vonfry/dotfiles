;;; diff packages -*- lexical-binding: t -*-
;;

(package! diff-hl
  :hook
  ((prog-mode . turn-on-diff-hl-mode)
  (vc-dir-mode . turn-on-diff-hl-mode)))
