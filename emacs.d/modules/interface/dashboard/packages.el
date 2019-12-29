;;; dashboard packages -*- lexical-binding: t -*-
;;

(package! dashboard
  :custom
  (dashboard-center-content t)
  (dashboard-startup-banner +dashboard-banner)
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
  (dashboard-navigator-buttons
      `(;; (icon title help action face prefix suffix)
        ((,(all-the-icons-octicon "mail" :height 1.1 :v-adjust 0.0)
           "Mail"
           "Check Mail"
           (lambda (&rest _) (mu4e)))
        (,(all-the-icons-material "chat" :height 1.0 :v-adjust 0.0)
          "Freenode"
          "Freenode"
          (lambda (&rest _) (circe "Freenode")))
        (,(all-the-icons-material "chat" :height 1.0 :v-adjust 0.0)
          "Gist"
          "Gist"
          (lambda (&rest _) (circe "Gist"))))
        ((,(all-the-icons-fileicon "gitlab" :height 1.0 :v-adjust 0.0)
           "Gitlab"
           "Goto Gitlab"
           (lambda (&rest _) (browse-url "https://gitlab.com/Vonfry")))
         (,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
           "Github"
           "Goto Github"
           (lambda (&rest _) (browse-url "https://github.com/Vonfry"))))))
  :hook
  (dashboard-mode . (lambda () (custom-set-variables '(show-trailing-whitespace nil))))
  :config
  (dashboard-setup-startup-hook)
  :general
  (+mmap-leader-def
    "X" '+dashboard-goto))
