;;; winner mode packages -*- lexical-binding: t -*-
;;

(winner-mode t)

(nmap-leader
  "W"   '(:ignore t :which-key "winner")
  "W r" 'winner-redo
  "W u" 'winner-undo)
