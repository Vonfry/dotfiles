;;; avy packages -*- lexical-binding: t -*-
;;

(package! avy
  :custom
  (avy-keys (list ?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
  :config
  (avy-setup-default)
  :general
  ("C-'"  'avy-goto-char-2)
  ("C-\"" 'avy-goto-line)
  ("C-:"  'avy-goto-char)
  (+mmap-leader-def "g" 'avy-goto-char-2)
  (+mmap-leader-def "/" 'avy-goto-char-timer)
  (+mmap-avy-def
    "" '(nil :which-key "avy")
    "g" 'avy-goto-char
    "f" 'avy-goto-char-in-line
    "b" 'avy-goto-word-0
    "w" 'avy-goto-word-1
    "W" 'avy-goto-subword-1
    "l" 'avy-goto-line
    "s" 'avy-goto-symbol-1
    "," 'avy-pop-mark
    ";" 'avy-push-mark))

(package! ace-window
  :after avy
  :custom
  (aw-keys '(?a ?i ?q ?d ?h ?t ?f ?p ?y))
  (aw-minibuffer-flag t)
  (aw-dispatch-always t)
  :general
  ("C-x o" 'ace-window)
  (+mmap-leader-def
    "w"        'ace-window
    "RET"      '+ace/append
    [return]   '+ace/append
    "S-RET"    '+ace/append-point
    [S-return] '+ace/append-point))
