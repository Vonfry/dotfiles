;;; hl-todo modules -*- lexical-binding: t; -*-
;;

(package! hl-todo
  :general
  (nmap :prefix +nmap-hl-todo-prefix
    "p" 'hl-todo-previous
    "n" 'hl-todo-next
    "o" 'hl-todo-occur))
