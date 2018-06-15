;;; winner mode packages -*- lexical-binding: t -*-
;;

(winner-mode t)

(nmap :prefix +nmap-winner-prefix
      ""  '(nil :which-key "winner")
      "r" 'winner-mode-redo
      "u" 'winner-mode-undo)
