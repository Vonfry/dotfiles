;;; orgmode packages -*- lexical-binding: t -*-
;;

(package! org
  :custom
  (org-clock-persist t)
  (org-clock-persist-file
    (expand-file-name "org-clock-save.el" vonfry-cache-dir))
  (org-log-done 'time)
  (org-adapt-indentation t)
  (org-hide-leading-stars t)
  (org-indent-indentation-per-level 1)
  (org-list-indent-offset 2)
  (org-id-locations-load (expand-file-name "org-id" vonfry-local-dir))
  (org-log-refile 'time)
  (org-refile-targets '((nil :maxlevel 99)
                        (+org-projectile-todo-project-file :maxlevel 99)
                        (org-agenda-files :maxlevel . 99)))
  :general
  ("C-c C" 'org-capture-goto-target)
  ("C-c a" 'org-agenda)
  (+mmap-mode-org-def
    "/"  'org-occur
    "n"  'next-error
    "p"  'previous-error
    "g"  'counsel-org-goto
    "l"  'counsel-org-link
    "e"  'counsel-org-entity
    "@"  'counsel-org-tag
    "^"  'counsel-org-tag-agenda
    "#"  'counsel-org-file
    "t"  'org-tags-view
    ","  'org-set-property
    "d"  'org-deadline
    "s"  'org-schedule
    "t"  'org-todo
    "m"  'org-refile
    "$"  'org-archive-subtree-default
    "c"  'org-ctrl-c-ctrl-c
    "h"  'avy-org-goto-heading-timer
    "D i" 'org-display-inline-images
    "D t" 'org-latex-preview
    "D k" 'org-toggle-link-display))

(package! org-superstar
  :after org
  :custom
  (org-superstar-headline-bullets-list '("☰" "☷" "☵" "☲"  "☳" "☴"  "☶"  "☱" ))
  :hook
  (org-mode . org-superstar-mode))

(package! evil-org
  :after (evil org)
  :hook
  (org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme))

(package! evil-org-agenda
  :after evil-org
  :ensure nil
  :config
  (evil-org-agenda-set-keys))

(package! org-agenda
  :ensure nil
  :after org
  :general
  (+mmap-note-def
    "a" 'org-agenda
    "A" '+org/find-agenda
    "n" '+org/find-notes
    "b" '+org/append-to-agenda-file
    "B" 'append-to-buffer
    "c" 'counsel-org-capture))

(package! org-archive
  :ensure nil
  :general
  (+mmap-mode-org-def
    "a" 'org-archive-subtree-default))

(package! org-web-tools
  :after org
  :general
  (+mmap-note-def
    "u" 'org-web-tools-read-url-as-org)
  (+mmap-mode-org-def
   "w"   '(nil :which-key "web")
   "w o" 'org-web-tools-read-url-as-org
   "w l" 'org-web-tools-insert-link-for-url
   "w e" 'org-web-tools-insert-web-page-as-entry
   "w A" 'org-web-tools-archive-view
   "w a" 'org-web-tools-archive-attach))

(package! org-journal
  :after org
  :custom
  (org-journal-file-format "%Y-%m.org")
  (org-journal-enable-agenda-integration t)
  (org-journal-find-file 'find-file)
  (org-journal-file-type 'monthly)
  :config
  (setq org-journal-cache-file (expand-file-name "org-journal.cache" vonfry-cache-dir))
  :general
  (+mmap-note-def
    "j n" 'org-journal-new-entry
    "j j" 'org-journal-open-next-entry
    "j k" 'org-journal-open-previous-entry
    "j /" 'org-journal-search
    "j s" 'org-journal-schedule-view))

(package! org-ql
  :general
  (+mmap-mode-org-def
    ";" 'org-ql-search
    "," 'org-ql-view
    "." 'org-ql-sparse-tree))

(package! org-roam
  :custom
  (org-roam-directory +org-note-dir)
  (org-roam-db-location (expand-file-name
                          (replace-regexp-in-string
                            "/" "!"
                             +org-note-dir)
                          +org-roam-local-dir))
  :general
  (+mmap-note-def
    "N"   'org-roam-find-file
    "C"   'org-roam-capture
    "R "  '(nil :which-key "org roam")
    "R b" 'org-roam-db-build-cache
    "R p" '+org/roam-switch)
  (+mmap-mode-org-def
    "r"   'org-roam
    "R "  '(nil :which-key "org roam")
    "R m" 'org-roam-mode
    "R g" 'org-roam-graph
    "R i" 'org-roam-insert))

(package! org-roam-server
  :general
  (+mmap-note-def
    "s" 'org-roam-server-mode))

(package! org-protocol :ensure nil)
(package! org-roam-protocol :ensure nil)

(package! ob
  :init
  (package! ob-emacs-lisp)
  (package! ob-org)
  (package! ob-http)
  (package! ob-haskell)
  (package! ob-R)
  (package! ob-latex)
  (package! ob-coq)
  (package! ob-sql)
  (package! ob-sqlite)
  (package! ob-perl)
  (package! ob-gnuplot)
  :after org)

(package! org-contacts
  :ensure org-plus-contrib
  :custom
  (org-contacts-files
   (if (file-exists-p +org-contacts-dir)
    (directory-files +org-contacts-dir t
                     "^[A-z0-9_\\-]+\\.org$")
    nil))
  :general
  (+mmap-at-def
    "C" '+org/find-contacts
    "c" 'org-contacts))

(package! org-toc
  :ensure org-plus-contrib
  :general
  (+mmap-mode-org-def
    "T" 'org-toc-show))
