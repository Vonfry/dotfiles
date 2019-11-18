;;; avy packages -*- lexical-binding: t -*-
;;

(package! avy
  :general
  (+nmap-avy-def
    "" '(nil :which-key "avy")
    "t" 'avy-goto-char
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
  (aw-keys '(?& ?[ ?{ ?} ?( ?\) ?+ ?] ?!))
  (aw-minibuffer-flag t)
  (aw-dispatch-always t)
  :general
  (+nmap-leader-def "w" 'ace-window))
