;;; avy/packages.el --- -*- lexical-binding: t -*-
;;

(use-package avy
  :custom
  (avy-keys (list ?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  (avy-orders-alist
   '((avy-goto-char . avy-order-closest)
     (avy-goto-char-2 . avy-order-closest)
     (avy-isearch . avy-order-closest)
     (avy-goto-line . avy-order-closest)
     (avy-goto-subword-0 . avy-order-closest)
     (avy-goto-subword-1 . avy-order-closest)
     (avy-goto-word-0 . avy-order-closest)
     (avy-goto-word-1 . avy-order-closest)
     (avy-copy-line . avy-order-closest)
     (avy-copy-region . avy-order-closest)
     (avy-move-line . avy-order-closest)
     (avy-move-region . avy-order-closest)
     (avy-kill-whole-line . avy-order-closest)
     (avy-kill-region . avy-order-closest)
     (avy-kill-ring-save-whole-line . avy-order-closest)
     (avy-kill-ring-save-region . avy-order-closest)))
  :config
  (avy-setup-default)
  :general
  ("C-'"  'avy-goto-symbol-1)
  ("C-\"" 'avy-goto-word-1)
  ("C-:"  'avy-goto-char-2)
  (nvmap-leader
    "g"   'avy-goto-symbol-1
    "J"   'avy-goto-line
    "j j" 'avy-goto-char-2
    "j l" 'avy-goto-line
    "j /" 'avy-goto-char-timer
    "j g" 'avy-goto-char
    "j w" 'avy-goto-word-1
    "j W" 'avy-goto-word-0
    "j f" 'avy-goto-char-in-line
    "j b" 'avy-goto-subword-1
    "j ," 'avy-pop-mark
    "j ;" 'avy-push-mark)
  (nmap-leader
    "j c" 'avy-move-line
    "j p" 'avy-copy-line
    "j d" 'avy-kill-ring-whole-line
    "j D" 'avy-kill-ring-save-whole-line)
  (vmap-leader
    "j c" 'avy-move-region
    "j p" 'avy-copy-region
    "j d" 'avy-kill-region
    "j D" 'avy-kill-ring-save-region))

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
