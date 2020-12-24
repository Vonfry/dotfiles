;;; avy packages -*- lexical-binding: t -*-
;;

(use-package avy
  :custom
  (avy-keys (list ?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  :config
  (avy-setup-default)
  :general
  ("C-'"  'avy-goto-char-2)
  ("C-\"" 'avy-goto-line)
  ("C-:"  'avy-goto-char)
  (nvmap-leader
    "g"   'avy-goto-char-2
    "/"   'avy-goto-char-timer
    "G"   '(:ignore t :which-key "avy")
    "G g" 'avy-goto-char
    "G f" 'avy-goto-char-in-line
    "G b" 'avy-goto-word-0
    "G w" 'avy-goto-word-1
    "G W" 'avy-goto-subword-1
    "G l" 'avy-goto-line
    "G s" 'avy-goto-symbol-1
    "G ," 'avy-pop-mark
    "G ;" 'avy-push-mark))

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
