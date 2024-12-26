;;; winner/mode.el --- packages -*- lexical-binding: t -*-
;;

(use-package winner
  :custom
  (winner-ring-size 50)
  :config
  (winner-mode t)
  :general
  (nmap-leader
    "W r" 'winner-redo
    "W u" 'winner-undo))
