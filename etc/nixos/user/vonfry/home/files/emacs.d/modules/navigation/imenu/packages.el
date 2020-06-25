;;; imenu packages -*- lexical-binding: t -*-
;;

(package! imenu
  :ensure nil
  :general
  (+mmap-prog-def
    ";" 'imenu))
