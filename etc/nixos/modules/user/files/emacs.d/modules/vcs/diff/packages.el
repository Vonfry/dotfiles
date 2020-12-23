;;; diff packages -*- lexical-binding: t -*-
;;

(use-package diff-hl
  :hook
  ((text-mode prog-mode) . diff-hl-flydiff-mode))
