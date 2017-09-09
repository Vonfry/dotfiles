;;; editorconfig config -*- lexical-binding: t -*-

(use-package! editorconfig
  :init
  (custom-set-variables
    '(editorconfig-exec-path "editorconfig"))
  :config
  (editorconfig-mode 1))
