;;; mail packages -*- lexical-binding: t -*-
;;

(package! wl
  :straight wanderlust
  :config
  (if +mail-local-config-file
    (load +mail-local-config-file t t)
    nil))
