;;; novel config -*- lexical-binding: t -*-

(use-package! nov
  :mode (("\\.epub\\'" . nov-mode))
  :config
  (custom-set-variables
    '(nov-save-place-file (expand-file-name "nov-places" vonfry-local-dir))))
