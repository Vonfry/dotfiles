;;; dashboard packages -*- lexical-binding: t -*-
;;

(package! dashboard
  :custom
  (dashboard-center-content t)
  (initial-buffer-choice '+dashboard--init)
  (dashboard-set-init-info nil)
  (dashboard-banner-logo-title "Happy Hacking!")
  (dashboard-show-shortcuts    t)
  (dashboard-set-navigator     t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons    t)
  (dashboard-items '((agenda    . 5)
                     (bookmarks . 5)
                     (projects  . 5)
                     (recents   . 10)))
  :config
  (dashboard-setup-startup-hook)
  :general
  (+mmap-leader-def
    "z" '+dashboard/goto))
