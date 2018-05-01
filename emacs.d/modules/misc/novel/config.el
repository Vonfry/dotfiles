;;; novel config -*- lexical-binding: t -*-

(use-package! nov
  :mode (("\\.epub\\'" . nov-mode))
  :custom
  (nov-save-place-file (expand-file-name "nov-places" vonfry-local-dir)))
