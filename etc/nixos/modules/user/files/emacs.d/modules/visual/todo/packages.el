;;; hl-todo/modules.el --- -*- lexical-binding: t; -*-
;;

(use-package hl-todo
  :hook ((prog-mode TeX-mode) . hl-todo-mode)
  :general
  (nmap-leader
    "k p" 'hl-todo-previous
    "k n" 'hl-todo-next
    "k o" 'hl-todo-occur))
