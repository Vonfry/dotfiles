;;; avy packages -*- lexical-binding: t -*-
;;

(use-package avy
  :custom
  (avy-keys (list ?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  :config
  (avy-setup-default)
  :general
  ("C-'"  'avy-goto-word-1)
  ("C-\"" 'avy-goto-word-0)
  ("C-:"  'avy-goto-char-2)
  (nvmap-leader
    "g"   'avy-goto-word-1
    "G"   'avy-goto-word-0
    "/"   'avy-goto-char-2
    "J"   'avy-goto-line
    "j"   '(:ignore t :which-key "avy")
    "j l" 'avy-goto-line
    "j /" 'avy-goto-char-timer
    "j g" 'avy-goto-char
    "j w" 'avy-goto-word-0
    "j f" 'avy-goto-char-in-line
    "j b" 'avy-goto-subword-1
    "j s" 'avy-goto-symbol-1
    "j ," 'avy-pop-mark
    "j ;" 'avy-push-mark))

(use-package ace-window
  :after avy
  :custom
  (aw-keys '(?a ?i ?q ?d ?h ?t ?f ?p ?y))
  (aw-minibuffer-flag t)
  (aw-dispatch-always t)
  :general
  ("C-x o" 'ace-window)
  (nmap-leader
    "w"   'ace-window)
  (vmap-leader
    "RET" '+ace/append)
  (nmap-leader
    "'"     '(:ignore t "eval")
    "' RET" '+ace/append-point))
