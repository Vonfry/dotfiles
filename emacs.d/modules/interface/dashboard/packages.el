;;; dashboard packages -*- lexical-binding: t -*-
;;

(package! dashboard
  :custom
  (dashboard-center-content t)
  (dashboard-startup-banner "~/.config/bg.png")
  (initial-buffer-choice '+dashboard-goto)
  (dashboard-banner-logo-title "Happy Hacking!")
  (dashboard-show-shortcuts    t)
  (dashboard-set-navigator     t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons    t)
  (dashboard-items '((agenda    . 5)
                     (bookmarks . 5)
                     (projects  . 5)
                     (recents   . 5)))
  :config
  (dashboard-setup-startup-hook)
  :general
  (+mmap-leader-def
    "X" '+dashboard-goto))
