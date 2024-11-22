;;; orgmode/packages.el --- -*- lexical-binding: t -*-
;;

(use-package org
  :custom
  (org-modules '(ol-doi ol-bbdb ol-bibtex ol-docview ol-gnus ol-info ol-irc
                 ol-mhe ol-eww ol-eshell ol-bookmark))
  (org-link-file-path-type 'relative)
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
    ; avoid the latter override.
    (+org--auto-mode-to-file-apps 'nov 'emacs)
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
      "** %(org-contacts-template-name)\n:PROPERTIES:\n:EMAIL: %(org-contacts-template-email)\s\n:PHONE:\n:ALIAS:\n:NICKNAME:\n:IGNORE:\n:ICON:\n:NOTE:\n:ADDRESS:\n:BIRTHDAY:\n:END:")
     ("N" "capture to a new note file."
      plain (function +org--refile-new-note)
      ":PROPERTIES:\n:CREATED: %U\n:END:\n#+title: %?\n#+author: Vonfry\n")))
  (org-archive-subtree-add-inherited-tags t)
  (org-html-htmlize-output-type 'css)
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
    "?"   'org-occur
    "g"   'org-goto
    "l"   'org-insert-link
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
    "i"   'org-insert-structure-template
    "'"   'org-edit-special
    "e"   'org-export-dispatch
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
    "o"   'org-store-link
    "D i" 'org-display-inline-images
    "D t" 'org-latex-preview
    "D k" 'org-toggle-link-display))

(use-package org-modern
  :after org
  :hook
  (org-mode . org-modern-mode))

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
  (nmap-leader
    "o /" 'org-ql-search
    "o v" 'org-ql-view-sidebar
    "o v" 'org-ql-view)
  (nmap-mode :keymaps 'org-mode-map
    "/" 'org-ql-sparse-tree
    ";" 'org-ql-find))

(use-package ob
  :ensure nil
  :init
  (use-package ob-emacs-lisp :ensure nil)
  (use-package ob-org :ensure nil)
  (use-package ob-http)
  (use-package ob-haskell :ensure nil)
  (use-package ob-latex :ensure nil)
  (use-package ob-sql :ensure nil)
  (use-package ob-sqlite :ensure nil)
  (use-package ob-lisp :ensure nil)
  (use-package ob-julia :ensure nil)
  (use-package ob-d2)
  :custom
  (org-babel-load-languages '((emacs-lisp . t)
                              (org        . t)
                              (http       . t)
                              (haskell    . t)
                              (lisp       . t)
                              (latex      . t)
                              (julia      . t)
                              (sql        . t)
                              (sqlite     . t)
                              (lisp       . t)
                              (d2         . t)))
  (org-babel-lisp-eval-fn #'sly-eval)
  :after org)

(use-package org-contacts
  :custom
  (org-contacts-icon-use-gravatar nil)
  (org-contacts-files
   (if (file-exists-p +org-contacts-dir)
     (directory-files +org-contacts-dir t
                      "^[A-z0-9_\\-]+\\.org$")
     (expand-file-name "contacts.org" vonfry-local-dir)))
  :general
  (nmap-at
    "C" '+org/find-contacts
    "c" 'org-contacts))

(use-package org-project-capture
  :after project
  :general
  (nmap-leader
    "o p p" 'org-project-capture-project-todo-completing-read
    "o p g" 'org-project-capture-goto-location-for-project
    "o p S" 'org-project-capture-per-project
    "o p s" 'org-project-capture-single-file)
  :custom
  (org-project-capture-projects-file
   (expand-file-name "projects.org" +org-agenda-dir))
  (org-project-capture-per-project-filepath "TODO.org")
  :config
  (setq org-project-capture-default-backend
        (make-instance 'org-project-capture-project-backend))
  (org-project-capture-single-file))

(use-package consult-notes
  :after consult
  :custom
  (consult-notes-file-dir-sources
   `(("Notes" ?n ,+org-note-dir)
     ("Agenda" ?a ,+org-agenda-dir)
     ("Contacts" ?c ,+org-contacts-dir)
     ("Daily" ?d ,+org-journal-dir)))
  (consult-notes-use-rg t)
  :config
  (consult-notes-org-headings-mode)
  :general
  (nmap-leader
    "o n /" 'consult-notes-search-in-all-notes
    "o n n" 'consult-notes))
