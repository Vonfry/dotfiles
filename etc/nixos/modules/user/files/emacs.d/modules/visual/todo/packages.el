;;; hl-todo modules -*- lexical-binding: t; -*-
;;

(package! hl-todo
  :hook ((prog-mode TeX-mode) . hl-todo-mode)
  :general
  (nmap-leader :infix "k"
    ""  '(:ignore t :which-key "todo")
    "p" 'hl-todo-previous
    "n" 'hl-todo-next
    "o" 'hl-todo-occur))
