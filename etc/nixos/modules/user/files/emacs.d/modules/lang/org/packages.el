;;; orgmode packages -*- lexical-binding: t -*-
;;

(use-package org
  :custom
  (org-startup-folded t)
  (org-default-notes-file +org-capture-file)
  (org-directory +org-dir)
  (org-clock-persist t)
  (org-clock-persist-file
    (expand-file-name "org-clock-save.el" vonfry-cache-dir))
  (org-log-done 'time)
  (org-adapt-indentation t)
  (org-hide-leading-stars t)
  (org-indent-indentation-per-level 1)
  (org-list-indent-offset 2)
  (org-id-link-to-org-use-id 'use-existing)
  (org-id-locations-file (expand-file-name "org/id" vonfry-local-dir))
  (org-log-refile 'time)
  (org-refile-targets '((nil :maxlevel . 99)
                        (org-contacts-files :maxlevel . 99)
                        (org-agenda-files :maxlevel . 99)))
  (org-agenda-files (list +org-agenda-dir +org-capture-file))
  (org-tag-alist
   (let ((file (expand-file-name ".tags.el" +org-dir)))
     (with-temp-buffer
       (when (file-exists-p file)
         (insert-file-contents file)
         (read (current-buffer))))))
  (org-file-apps '((auto-mode . emacs)
                   (remote . emacs)))
  (org-file-apps-gnu
   (append
    (+org--auto-mode-to-file-apps 'doc-view-mode-maybe 'system)
    (+org--auto-mode-to-file-apps 'image-mode 'system)
    '((system . browse-url-xdg-open)
      (t . system))))
  (org-todo-keywords
   '((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")
     (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")))
  (org-capture-templates
   '(("t" "capture to inbox(Tasks), refile later"
      entry (file+headline +org-capture-file "Tasks")
      "** TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:")
     ("i" "capture to inbox(Idea), refile later"
      entry (file+headline +org-capture-file "Idea")
      "** %?\n:PROPERTIES:\n:CREATED: %U\n:END:")
     ("n" "capture to inbox(Note), refile later"
      entry (file+headline +org-capture-file "Notes")
      "** %?\n:PROPERTIES:\n:CREATED: %U\n:END:")
     ("c" "Contacts" entry (file+headline +org-capture-file "Contacts")
      "** %(org-contacts-template-name)\n:PROPERTIES:\n:EMAIL: %(org-contacts-template-email)\s\n:PHONE:\n:ALIAS:\n:NICKNAME:\n:IGNORE:\n:ICON:\n:NOTE:\n:ADDRESS:\n:BIRTHDAY:\n:END:")))
  (org-archive-subtree-add-inherited-tags t)
  :general
  ("C-c C" 'org-capture-goto-target)
  ("C-c a" 'org-agenda)
  (nmap-leader
    "o t i" 'org-clock-in-last
    "o t o" 'org-clock-out
    "o t q" 'org-clock-cancel
    "o t d" 'org-clock-display
    "o t j" 'org-clock-goto)
  (nvmap-mode :keymaps 'org-mode-map
    "/"   'org-occur
    "g"   'org-goto
    "L"   'org-store-link
    "@"   'org-set-tags-command
    "^"   'org-agenda-set-tags
    "T"   'org-tags-view
    "p"   'org-set-property
    ","   'org-priority
    "<"   'org-columns
    "d"   'org-deadline
    "s"   'org-schedule
    "t"   'org-todo
    "m"   'org-refile
    "$"   'org-archive-subtree-default
    "c"   'org-ctrl-c-ctrl-c
    "C i" 'org-clock-in
    "C I" 'org-clock-in-last
    "C o" 'org-clock-out
    "C q" 'org-clock-cancel
    "C d" 'org-clock-display
    "C j" 'org-clock-goto
    "C e" 'org-evaluate-time-range
    "C E" 'org-clock-modify-effort-estimate
    "h"   'avy-org-goto-heading-timer
    "u"   'org-id-get-create
    "U"   'org-id-update-id-locations
    "G"   'org-id-goto
    "o"   'org-store-link
    "O"   'org-id-store-link
    "D i" 'org-display-inline-images
    "D t" 'org-latex-preview
    "D k" 'org-toggle-link-display))

(use-package org-superstar
  :after org
  :custom
  (org-superstar-headline-bullets-list '("☰" "☷" "☵" "☲"  "☳" "☴"  "☶"  "☱" ))
  :hook
  (org-mode . org-superstar-mode))

(use-package evil-org
  :after (evil org)
  :hook
  (org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme))

(use-package evil-org-agenda
  :after evil-org
  :ensure nil
  :config
  (evil-org-agenda-set-keys))

(use-package org-agenda
  :ensure nil
  :after org
  :general
  (nmap-leader
    "o a" 'org-agenda
    "o A" '+org/find-agenda
    "o N" '+org/find-notes
    "o b" '+org/append-to-agenda-file
    "o B" 'append-to-buffer
    "o c" 'org-capture
    "o k" '+org/open-capture))

(use-package org-archive
  :ensure nil
  :general
  (+mmap-mode-org-def
    "a" 'org-archive-subtree-default))

(use-package org-web-tools
  :after org
  :general
  (nmap-leader
    "o u" 'org-web-tools-read-url-as-org)
  (nmap-mode :keymaps 'org-mode-map
   "w o" 'org-web-tools-read-url-as-org
   "w l" 'org-web-tools-insert-link-for-url
   "w e" 'org-web-tools-insert-web-page-as-entry
   "w A" 'org-web-tools-archive-view
   "w a" 'org-web-tools-archive-attach))

(use-package org-journal
  :after org
  :custom
  (org-journal-file-format "%Y-%m.org")
  (org-journal-enable-agenda-integration nil)
  (org-journal-find-file 'find-file)
  (org-journal-file-type 'monthly)
  (org-journal-dir +org-journal-dir)
  :config
  (setq org-journal-cache-file (expand-file-name "org-journal.cache" vonfry-cache-dir))
  :general
  (nmap-leader
    "o j n" 'org-journal-new-entry
    "o j j" 'org-journal-open-next-entry
    "o j k" 'org-journal-open-previous-entry
    "o j /" 'org-journal-search
    "o j s" 'org-journal-schedule-view))

(use-package org-ql
  :general
  (nmap-mode :keymaps 'org-mode-map
    "." 'org-ql-search
    "," 'org-ql-view
    ";" 'org-ql-sparse-tree))

(use-package org-roam
  :init
  (+org--roam-set-path +org-note-dir)
  :custom
  (org-roam-graph-viewer 'org-open-file)
  :config
  (org-roam-setup)
  :general
  (nmap-leader
    "o n"   'org-roam-node-find
    "o C"   'org-roam-capture
    "o R m" 'org-roam-setup
    "o R M" 'org-roam-teardown
    "o R i" 'org-roam-node-insert
    "o R b" 'org-roam-db-sync
    "o R p" '+org/roam-switch)
  (nmap-mode :keymaps 'org-mode-map
    "r"   'org-roam-buffer-toggle
    "R g" 'org-roam-graph
    "R f" 'org-roam-node-find
    "R i" 'org-roam-node-insert))

(use-package org-roam-ui
  :general
  (nmap-leader
    "o s" 'org-roam-ui-open)
  :custom
  (org-roam-ui-port 8800))

(use-package ob
  :init
  (use-package ob-emacs-lisp)
  (use-package ob-org)
  (use-package ob-http)
  (use-package ob-haskell)
  (use-package ob-R)
  (use-package ob-latex)
  (use-package ob-sql)
  (use-package ob-sqlite)
  (use-package ob-perl)
  :custom
  (org-babel-load-languages '((emacs-lisp . t)
                              (org        . t)
                              (http       . t)
                              (haskell    . t)
                              (latex      . t)
                              (R          . t)
                              (sql        . t)
                              (sqlite     . t)
                              (perl       . t)))
  :after org)

(use-package org-contacts
  :custom
  (org-contacts-icon-use-gravatar nil)
  (org-contacts-files
   (if (file-exists-p +org-contacts-dir)
    (directory-files +org-contacts-dir t
                     "^[A-z0-9_\\-]+\\.org$")
    nil))
  :general
  (nmap-at
    "C" '+org/find-contacts
    "c" 'org-contacts))

(use-package toc-org
  :config
  (add-to-list 'org-tag-persistent-alist '("TOC" . ?T))
  :general
  (nmap-mode :keymaps 'org-mode-map
    "T" 'toc-org-mode))
