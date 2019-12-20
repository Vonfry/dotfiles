;;; mail packages -*- lexical-binding: t -*-
;;

(package! wanderlust
  :custom
  :config
  (if +mail-local-config-file
    (load +mail-local-config-file t t)
    nil))
