;;; nov/packages.el --- -*- lexical-binding: t -*-
;;

(use-package nov
  :mode "\\.epub\\'"
  :custom
  (nov-unzip-program (executable-find "arc"))
  (nov-unzip-args '("unarchive" "-ext" "zip" filename)))
