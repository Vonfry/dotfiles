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
  (dashboard-footer
   (replace-regexp-in-string
     " +"
     " "
     (replace-regexp-in-string
       "\n"
       " "
       (replace-regexp-in-string
         (concat (string 27) "\\[[0-9;]*[A-z]" (string 29) "?")
         ""
         (shell-command-to-string "fortune -s ~/.local/src/fortunes/data all")))))
  :config
  (dashboard-setup-startup-hook)
  :general
  (+mmap-leader-def
    "SPC" '+dashboard-goto))
