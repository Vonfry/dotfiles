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
   (let ((bg-file-default (expand-file-name "bg.png" (xdg-config-home))))
     (if (file-exists-p bg-file-default)
         bg-file-default
       'logo)))
  (dashboard-navigator-buttons
   `(;; (icon title help action face prefix suffix)
     ((,(all-the-icons-fileicon "lisp" :height 1.0 :v-adjust 0.0)
       "Scrath"
       "Goto scrath buffer"
       (lambda (&rest _) (switch-to-buffer "*scrath*")))
      (,(all-the-icons-material "folder" :height 1.0 :v-adjust 0.0)
       "Files"
       "Files Manager"
       (lambda (&rest _) (ranger))))
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
       (lambda (&rest _) (call-interactively +irc/connect)))
      )
     ((,(all-the-icons-fileicon "gitlab" :height 1.0 :v-adjust 0.0)
       "Gitlab"
       "Goto Gitlab"
       (lambda (&rest _) (browse-url "https://gitlab.com/Vonfry")))
      (,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
       "Github"
       "Goto Github"
       (lambda (&rest _) (browse-url "https://github.com/Vonfry"))))))
  (dashboard-items '((agenda    . 5)
                     (bookmarks . 5)
                     (projects  . 5)
                     (recents   . 10)))
  :config
  (dashboard-setup-startup-hook)
  :general
  (nmap-leader
    "z" '+dashboard/goto))
