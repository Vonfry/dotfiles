;;; ace-window packages -*- lexical-binding: t -*-
;;

(package! ace-window
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-minibuffer-flag t)
  (aw-dispatch-always t)
  :general
  ("M-w" 'ace-window)
  (nmap :prefix +nmap-leader
        +nmap-window 'ace-window))
