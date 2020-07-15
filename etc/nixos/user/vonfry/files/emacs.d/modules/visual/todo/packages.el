;;; hl-todo modules -*- lexical-binding: t; -*-
;;

(package! hl-todo
  :hook ((prog-mode TeX-mode) . hl-todo-mode)
  :general
  (+mmap-noto-def
    "{" 'hl-todo-previous
    "}" 'hl-todo-next
    "o" 'hl-todo-occur))
