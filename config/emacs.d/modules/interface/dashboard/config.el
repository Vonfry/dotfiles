;;; dashboard config -*- lexical-binding: t -*-
;;

(custom! +dashboard-banner (if (file-exists-p "~/.config/bg.png") "~/.config/bg.png" 'logo)
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'dashboard-startup-banner)

(custom! +dashboard-navigator-buttons
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
     (lambda (&rest _) (browse-url "https://github.com/Vonfry")))))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'dashboard-navigator-buttons)
