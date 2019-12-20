;;; mail packages -*- lexical-binding: t -*-
;;

(package! wl
  :straight wanderlust
  :init
  (straight-use-package apel)
  (straight-use-package semi)
  (straight-use-package flim)
  :config
  (if +mail-local-config-file
    (load +mail-local-config-file t t)
    nil))
