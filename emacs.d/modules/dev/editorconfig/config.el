;;; editorconfig config -*- lexical-binding: t -*-

(vonfry|use-package! editorconfig
  :init
  (custom-set-variables
    '(editorconfig-exec-path "editorconfig"))
  :config
  (editorconfig-mode 1))
