;;; hl-todo/modules.el --- -*- lexical-binding: t; -*-
;;

(use-package hl-todo
  :hook ((prog-mode TeX-mode) . hl-todo-mode)
  :general
  (nmap-leader
    "j t p" 'hl-todo-previous
    "j t n" 'hl-todo-next
    "j t o" 'hl-todo-occur))
