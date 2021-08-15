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
    "/"   'avy-goto-char-2
    "G"   '(:ignore t :which-key "avy")
    "G l" 'avy-goto-line
    "G /" 'avy-goto-char-timer
    "G g" 'avy-goto-char
    "G w" 'avy-goto-word-0
    "G f" 'avy-goto-char-in-line
    "G b" 'avy-goto-subword-1
    "G s" 'avy-goto-symbol-1
    "G ," 'avy-pop-mark
    "G ;" 'avy-push-mark))

(use-package ace-window
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
