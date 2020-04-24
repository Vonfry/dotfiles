;;; diff packages -*- lexical-binding: t -*-
;;

(package! diff-hl
  :hook
  ((text-mode prog-mode) . diff-hl-flydiff-mode))
