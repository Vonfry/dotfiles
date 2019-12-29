;;; dashboard packages -*- lexical-binding: t -*-
;;

(package! dashboard
  :custom
  (dashboard-center-content t)
; (dashboard-startup-banner +dashboard-banner)
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
; (dashboard-navigator-buttons +dashboard-navigator-buttons)
  :hook
  (dashboard-mode . (lambda () (custom-set-variables '(show-trailing-whitespace nil))))
  :config
  (dashboard-setup-startup-hook)
  :general
  (+mmap-leader-def
    "X" '+dashboard-goto))
