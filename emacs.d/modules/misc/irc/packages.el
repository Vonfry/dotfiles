;;; irc packages -*- lexical-binding: t -*-
;;

(package! circe
  :custom
  (circe-reduce-lurker-spam t)
  :hook
  ((circe-server circe-channel circe-query circe-chat circe-lagmon circe-display circe) .
   (lambda () (custom-set-variables '(show-trailing-whitespace nil))))
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
