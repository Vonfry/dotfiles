;;; hl-todo modules -*- lexical-binding: t; -*-
;;

(package! hl-todo
  :hook ((prog-mode TeX-mode) . hl-todo-mode)
  :general
  (+mmap-note-def
    "o"   '(nil :which-key "todo")
    "o {" 'hl-todo-previous
    "o }" 'hl-todo-next
    "o o" 'hl-todo-occur))
