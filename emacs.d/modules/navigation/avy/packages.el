;;; avy packages -*- lexical-binding: t -*-
;;

(package! avy
  :general
  (nmap :prefix +nmap-avy-prefix
        "" '(nil :which-key "avy")
        "f" 'avy-goto-char
        "F" 'avy-goto-char-2
        "t" 'avy-goto-char-timer
        "T" 'avy-goto-word-0
        "w" 'avy-goto-word-1
        "W" 'avy-goto-subword-1
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
  (nmap :prefix +nmap-leader
        +nmap-window 'ace-window))
