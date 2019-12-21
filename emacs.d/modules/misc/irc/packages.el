;;; irc packages -*- lexical-binding: t -*-
;;

(package! circe
  :config
  (load +irc-local-config-file t t)
  :general
  (+mmap-at-def
    "i" 'circe))
