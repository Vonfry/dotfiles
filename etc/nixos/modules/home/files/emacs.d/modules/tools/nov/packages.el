;;; nov/packages.el --- -*- lexical-binding: t -*-
;;

(use-package nov
  :mode "\\.epub\\'"
  :custom
  (nov-unzip-program (executable-find "ouch"))
  (nov-unzip-args '("decompress" "--format" "zip" "--dir" directory filename))
  )
