;;; orgmode packages -*- lexical-binding: t -*-
;;

(package! org
  :custom
  (org-clock-persist t)
  (org-clock-persist-file
    (expand-file-name "org-clock-save.el" vonfry-cache-dir))
  (org-log-done 'time)
  (org-startup-indented t)
  (org-indent-mode-turns-off-org-adapt-indentation nil)
  (org-indent-indentation-per-level 1)
  (org-list-indent-offset 2)
; (org-agenda-custom-commands +org-agenda-custom-commands)
; (org-default-notes-file +org-capture-file)
; (org-capture-templates +org-capture-templates)
; (org-todo-keywords +org-todo-keywords-sequence)
; (org-refile-targets +org-refile-targets)
; (org-tag-alist +org-tag-alist)
  :general
  ("C-c C" 'org-capture-goto-target)
  ("C-c a" 'org-agenda)
  (+mmap-mode-org-def
    "/"  'org-sparse-tree
    "\\" 'org-tags-sparse-tree
    "t"  'org-tags-view
    "p"  'org-set-property
    "d"  'org-deadline
    "s"  'org-schedule
    "t"  'org-todo
    "$"  'org-archive-subtree-default
    "c"  'org-ctrl-c-ctrl-c))

(package! org-bullets
  :after org
  :hook
  (org-mode . org-bullets-mode))

(package! evil-org
  :after evil org
  :hook
  (org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme))

(package! evil-org-agenda
  :after evil-org
  :ensure nil
  :config
  (evil-org-agenda-set-keys))

(package! org-brain
  :after org
  :custom
; (org-brain-path +org-brains-path)
  (org-id-track-globally t)
  (org-id-locations-file (expand-file-name "org-id-locations" vonfry-cache-dir))
  (org-brain-visualize-default-choices 'all)
  (org-brain-title-max-length 16)
  :config
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs)))

(package! org-agenda
  :ensure nil
  :after org
; :custom
; (org-agenda-files +org-agenda-files)
  :general
  (+mmap-todo-def
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
  (+mmap-at-def
    "w o" 'org-web-tools-read-url-as-org)
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
; (org-journal-dir +org-journal-dir)
; (org-journal-tag-alist +org-journal-tag-alist)
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-enable-agenda-integration t)
  :config
  (setq org-journal-cache-file (expand-file-name "org-journal.cache" vonfry-cache-dir))
  :general
  (+mmap-todo-def
    "j n" 'org-journal-new-entry
    "j j" 'org-journal-open-next-entry
    "j k" 'org-journal-open-previous-entry
    "j /" 'org-journal-search
    "j s" 'org-journal-schedule-view))
