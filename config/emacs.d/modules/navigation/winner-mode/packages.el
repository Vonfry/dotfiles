;;; winner mode packages -*- lexical-binding: t -*-
;;

(winner-mode t)

(+mmap-winner-def
  ""  '(nil :which-key "winner")
  "r" 'winner-mode-redo
  "u" 'winner-mode-undo)