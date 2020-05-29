;;; avy packages -*- lexical-binding: t -*-
;;

(package! avy
  :general
  (+mmap-leader-def "g" 'avy-goto-char-2)
  (+mmap-leader-def "/" 'avy-goto-char-timer)
  (+mmap-avy-def
    "" '(nil :which-key "avy")
    "." 'avy-goto-char
    "f" 'avy-goto-char-2
    "g" 'avy-goto-char-timer
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
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (aw-minibuffer-flag t)
  (aw-dispatch-always t)
  :general
  (+mmap-leader-def
    "w"   'ace-window
    "RET" '+ace/append
    "S-<return>" '+ace/append-point))
