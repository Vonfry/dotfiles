;;; winner/mode.el --- packages -*- lexical-binding: t -*-
;;

(winner-mode t)

(nmap-leader
  "W r" 'winner-redo
  "W u" 'winner-undo)
