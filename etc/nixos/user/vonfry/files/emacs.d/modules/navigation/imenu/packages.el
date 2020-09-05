;;; imenu packages -*- lexical-binding: t -*-
;;

(package! imenu
  :ensure nil
  :general
  (+mmap-leader-def
    ";" 'imenu))
