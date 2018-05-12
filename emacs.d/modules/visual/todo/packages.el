;;; hl-todo modules -*- lexical-binding: t; -*-
;;

(package! hl-todo
  :general
  (nmap :prefix +hl-todo-prefix-keybind
    "p" 'hl-todo-previous
    "n" 'hl-todo-next
    "o" 'hl-todo-occur))
