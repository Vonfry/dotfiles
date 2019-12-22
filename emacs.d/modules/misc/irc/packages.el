;;; irc packages -*- lexical-binding: t -*-
;;

(package! circe
  :custom
  (circe-reduce-lurker-spam t)
  :general
  (+mmap-at-def
    "i"   '(nil :which-key "irc")
    "i i" 'circe
    "i a" 'tracking-next-buffer
    "i j" 'circe-command-JOIN
    "i p" 'circe-command-PART
    "i R" 'circe-reconnect
    "i c" '+irc/ivy-jump-to-channel
    "i n" 'circe-command-NAMES))
