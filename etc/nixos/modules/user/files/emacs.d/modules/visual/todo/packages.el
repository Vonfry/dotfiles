;;; hl-todo modules -*- lexical-binding: t; -*-
;;

(use-package hl-todo
  :hook ((prog-mode TeX-mode) . hl-todo-mode)
  :general
  (nmap-leader :infix "k"
    "p" 'hl-todo-previous
    "n" 'hl-todo-next
    "o" 'hl-todo-occur))
