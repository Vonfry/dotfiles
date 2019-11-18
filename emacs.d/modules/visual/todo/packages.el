;;; hl-todo modules -*- lexical-binding: t; -*-
;;

(package! hl-todo
  :hook (prog-mode . hl-todo-mode)
  :general
  (+nmap-todo-def
    ""  '(nil :which-key "todo")
    "p" 'hl-todo-previous
    "n" 'hl-todo-next
    "o" 'hl-todo-occur))
