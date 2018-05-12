;;; winner mode packages -*- lexical-binding: t -*-
;;

(winner-mode t)

(nmap :prefix +winner-mode-nmap-prefix
      "r" 'winner-mode-redo
      "u" 'winner-mode-undo)
