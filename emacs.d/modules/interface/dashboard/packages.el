;;; dashboard packages -*- lexical-binding: t -*-
;;

(package! dashboard
  :custom
  (dashboard-center-content t)
  (initial-buffer-choice '+dashboard-goto)
  (dashboard-set-init-info nil)
  (dashboard-banner-logo-title "Happy Hacking!")
  (dashboard-show-shortcuts    t)
  (dashboard-set-navigator     t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons    t)
  (dashboard-items '((agenda    . 5)
                     (bookmarks . 5)
                     (projects  . 5)
                     (recents   . 5)))
  ; TODO remove these when dashboard use defcustom instead of defvar
  (dashboard-navigator-buttons +dashboard-navigator-buttons)
  (dashboard-startup-banner +dashboard-banner)
  (dashboard-footer
   (shell-command-to-string "fortune -s ~/.local/src/fortunes/data all"))
  :config
  (dashboard-setup-startup-hook)
  :general
  (+mmap-leader-def
    "X" '+dashboard-goto))
