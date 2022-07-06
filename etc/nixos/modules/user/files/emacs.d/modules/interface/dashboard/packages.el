;;; dashboard packages -*- lexical-binding: t -*-
;;

(use-package dashboard
  :custom
  (dashboard-center-content t)
  (initial-buffer-choice '+dashboard--init)
  (dashboard-set-init-info nil)
  (dashboard-banner-logo-title "Happy Hacking!")
  (dashboard-show-shortcuts    t)
  (dashboard-set-navigator     t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons    t)
  (dashboard-startup-banner
   (let ((bg-file-default (expand-file-name "dashboard-image.png" vonfry-local-dir)))
     (if (file-exists-p bg-file-default)
         bg-file-default
       'logo)))
  (dashboard-navigator-buttons
   `(;; (icon title help action face prefix suffix)
     ((,(all-the-icons-fileicon "lisp" :height 1.0 :v-adjust 0.0)
       "Scratch"
       "Goto scrath buffer"
       (lambda (&rest _) (+evil/switch-scratch)))
      (,(all-the-icons-material "folder" :height 1.0 :v-adjust 0.0)
       "Files"
       "Files Manager"
       (lambda (&rest _) (dirvish)))
      (,(all-the-icons-material "queue_music" :height 1.0 :v-adjust 0.0)
       "Music"
       "Music Player Daemon"
       (lambda (&rest _) (mpdel-playlist-open))))
     ((,(all-the-icons-octicon "mail" :height 1.1 :v-adjust 0.0)
       "Mail"
       "Check Mail"
       (lambda (&rest _) (mu4e)))
      (,(all-the-icons-material "rss_feed" :height 1.0 :v-adjust 0.0)
       "Feed"
       "Feed"
       (lambda (&rest _) (elfeed)))
      (,(all-the-icons-material "chat" :height 1.0 :v-adjust 0.0)
       "IRC"
       "IRC"
       (lambda (&rest _) (call-interactively '+irc/connect)))
      (,(all-the-icons-material "chat" :height 1.0 :v-adjust 0.0)
       "Telega"
       "Telega"
       (lambda (&rest _) (call-interactively 'telega)))
      )
     ((,(all-the-icons-octicon "home" :height 1.0 :v-adjust 0.0)
       "Website"
       "Goto vonfry.name"
       (lambda (&rest _) (browse-url "https://vonfry.name")))
      (,(all-the-icons-octicon "repo" :height 1.0 :v-adjust 0.0)
       "Repos"
       "Goto repos"
       (lambda (&rest _) (browse-url "https://sr.ht/~vonfry"))))))
  (dashboard-projects-backend 'project-el)
  (dashboard-items '((agenda    . 5)
                     (bookmarks . 5)
                     (projects  . 5)
                     (recents   . 10)))
  :config
  (dashboard-setup-startup-hook)
  :general
  (nmap-leader
    "z" '+dashboard/goto))
