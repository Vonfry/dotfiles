;;; orgmode packages -*- lexical-binding: t -*-
;;

(use-package org
  :custom
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
  (org-agenda-files
   (append (directory-files +org-agenda-dir t
                            "^[A-z0-9\\-_]+\\.org$")
           (list +org-capture-file)))
  (org-tag-alist
   (let ((file (expand-file-name ".tags.el" +org-agenda-dir)))
    (eval (read-from-whole-string
     (with-temp-buffer
       (when (file-exists-p file)
         (insert-file-contents file)
         (buffer-string)))))))
  (org-agenda-tags org-tag-alist)
  (org-file-apps '((system . "xdg-open %s")
                   ("\\.mm\\'" . default)
                   ("\\.x?html?\\'" . default)
                   ("\\.pdf\\'" . system)
                   (auto-mode . emacs)))
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
  (nvmap-mode :keymaps 'org-mode-map
    "/"   'org-occur
    "n"   'next-error
    "p"   'previous-error
    "g"   'counsel-org-goto
    "l"   'counsel-org-link
    "L"   'org-store-link
    "e"   'counsel-org-entity
    "@"   'counsel-org-tag
    "^"   'counsel-org-tag-agenda
    "#"   'counsel-org-file
    "t"   'org-tags-view
    ","   'org-set-property
    "d"   'org-deadline
    "s"   'org-schedule
    "t"   'org-todo
    "m"   'org-refile
    "$"   'org-archive-subtree-default
    "c"   'org-ctrl-c-ctrl-c
    "h"   'avy-org-goto-heading-timer
    "D"   '(:ignore t :which-key "display")
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
  (nmap-leader :infix "o"
    ""  '(:ignore t :which-key "notes")
    "h" 'counsel-org-agenda-headlines
    "a" 'org-agenda
    "A" '+org/find-agenda
    "n" '+org/find-notes
    "b" '+org/append-to-agenda-file
    "B" 'append-to-buffer
    "c" 'org-capture
    "k" '+org/open-capture))

(use-package org-archive
  :ensure nil
  :general
  (+mmap-mode-org-def
    "a" 'org-archive-subtree-default))

(use-package org-web-tools
  :after org
  :general
  (nmap-leader :infix "o"
    "u" 'org-web-tools-read-url-as-org)
  (nmap-mode :keymaps 'org-mode-map
   "w"   '(:ignore t :which-key "web")
   "w o" 'org-web-tools-read-url-as-org
   "w l" 'org-web-tools-insert-link-for-url
   "w e" 'org-web-tools-insert-web-page-as-entry
   "w A" 'org-web-tools-archive-view
   "w a" 'org-web-tools-archive-attach))

(use-package org-journal
  :after org
  :custom
  (org-journal-file-format "%Y-%m.org")
  (org-journal-enable-agenda-integration t)
  (org-journal-find-file 'find-file)
  (org-journal-file-type 'monthly)
  (org-journal-dir +org-journal-dir)
  (org-journal-tags
   (let ((file (expand-file-name ".tags.el" +org-journal-dir)))
     (eval (read-from-whole-string
       (with-temp-buffer
         (when (file-exists-p file)
           (insert-file-contents file)
           (buffer-string)))))))
  :config
  (setq org-journal-cache-file (expand-file-name "org-journal.cache" vonfry-cache-dir))
  :general
  (nmap-leader :infix "o j"
    ""  '(:ignore t :which-key "journal")
    "n" 'org-journal-new-entry
    "j" 'org-journal-open-next-entry
    "k" 'org-journal-open-previous-entry
    "/" 'org-journal-search
    "s" 'org-journal-schedule-view))

(use-package org-ql
  :general
  (nmap-mode :keymaps 'org-mode-map
    ";" 'org-ql-search
    "," 'org-ql-view
    "." 'org-ql-sparse-tree))

(use-package org-roam
  :init
  (+org--roam-set-path +org-note-dir)
  :custom
  (org-roam-capture-templates
   '(("d" "default" plain #'org-roam-capture--get-point "%?"
      :file-name "%(+org--roam-capture-note-dir)/${slug}"
      :head "#+title: ${title}"
      :unnarrowed t)))
  :general
  (nmap-leader :infix "o"
    "N"   'org-roam-find-file
    "C"   'org-roam-capture
    "R "  '(:ignore t :which-key "org roam")
    "R b" 'org-roam-db-sync
    "R p" '+org/roam-switch)
  (nmap-mode :keymaps 'org-mode-map
    "r"   'org-roam-buffer-toggle
    "R "  '(:ignore t :which-key "org roam")
    "R m" 'org-roam-setup
    "R M" 'org-roam-teardown
    "R g" 'org-roam-graph
    "R i" 'org-roam-insert))

(use-package org-roam-server
  :general
  (nmap-leader :infix "o"
    "s" 'org-roam-server-mode)
  :custom
  (org-roam-server-port 8100))

(use-package org-protocol :ensure nil)
(use-package org-roam-protocol :ensure nil)

(use-package ob
  :init
  (use-package ob-emacs-lisp)
  (use-package ob-org)
  (use-package ob-http)
  (use-package ob-haskell)
  (use-package ob-R)
  (use-package ob-latex)
  (use-package ob-coq)
  (use-package ob-sql)
  (use-package ob-sqlite)
  (use-package ob-perl)
  :custom
  (org-babel-load-languages '((emacs-lisp . t)
                              (org        . t)
                              (http       . t)
                              (haskell    . t)
                              (latex      . t)
                              (coq        . t)
                              (R          . t)
                              (sql        . t)
                              (sqlite     . t)
                              (perl       . t)))
  :after org)

(use-package org-contacts
  :ensure org-plus-contrib
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

(use-package org-toc
  :ensure org-plus-contrib
  :general
  (nmap-mode :keymaps 'org-mode-map
    "T" 'org-toc-show))
