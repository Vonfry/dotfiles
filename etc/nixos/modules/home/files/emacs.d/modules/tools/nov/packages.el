;;; nov/packages.el --- -*- lexical-binding: t -*-
;;

(use-package nov
  :mode "\\.epub\\'"
  ; :custom
  ; FIXME current ouch will always create a new dir, which is different from
  ; unzip.
  ; (nov-unzip-program (executable-find "ouch"))
  ; (nov-unzip-args '("decompress" "--format" "zip" "--dir" directory filename))
  )
