;;; ace-window packages -*- lexical-binding: t -*-
;;
;; ace-window is depending on avy, this file also config avy.

(package! ace-window
  :custom
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-minibuffer-flag t)
  (aw-dispatch-always t)
  :general
  (nmap :prefix +nmap-leader
    +nmap-window 'ace-window)
  (nmap :prefix +nmap-avy-prefix
        ":" 'avy-goto-char
        "," 'avy-pop-mark
        "'" 'avy-goto-char-2
        "f" 'avy-goto-line
        "w" 'avy-goto-word-1
        "e" 'avy-goto-word-0
        "j" 'avy-resume)
  ("M-w" 'ace-window)
  ("C-:" 'avy-goto-char)
  ("C-'" 'avy-goto-char-2)
  ("M-g f" 'avy-goto-line)
  ("M-g w" 'avy-goto-word-1)
  ("M-g e" 'avy-goto-word-0)
  ("C-c C-j" 'avy-resume))
