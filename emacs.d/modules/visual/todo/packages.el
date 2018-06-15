;;; hl-todo modules -*- lexical-binding: t; -*-
;;

(package! hl-todo
  :hook (prog-mode . hl-todo-mode)
  :general
  (nmap :prefix +nmap-hl-todo-prefix
        ""  '(nil :which-key "hl-todo")
        "p" 'hl-todo-previous
        "n" 'hl-todo-next
        "o" 'hl-todo-occur))
