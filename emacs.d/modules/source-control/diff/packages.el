;;; diff packages -*- lexical-binding: t -*-
;;

(package! diff-hl
  :hook
  ((text-mode . turn-on-diff-hl-mode)
  (vc-dir-mode . turn-on-diff-hl-mode)))
