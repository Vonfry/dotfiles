;;; org config -*- lexical-binding: t -*-
;;

;; +mmap-note-def
(mmap-leader-prefix! note "o")

(+mmap-note-def "" '(nil :which-key "note"))

(mmap-mode-prefix! org nil
  :keymaps 'org-mode-map)

(custom! +org-file-apps
         '((system . "xdg-open %s")
           ("\\.mm\\'" . default)
           ("\\.x?html?\\'" . default)
           ("\\.pdf\\'" . system)
           (auto-mode . emacs))
  "org file apps"
  :group 'vonfry-modules
  :custom-set 'org-file-apps)

(custom! +org-dir (let ((env-orgmode-dir (getenv "ORG_DIR")))
                    (if env-orgmode-dir env-orgmode-dir "~/orgmode"))
  "org dir"
  :type 'directory
  :group 'vonfry-modules
  :custom-set 'org-directory)

(custom! +org-capture-file
   (expand-file-name "inbox.org" +org-dir)
   ""
   :type 'file
   :group 'vonfry-modules
   :custom-set 'org-capture-file)

(custom! +org-agenda-dir (expand-file-name "agenda" +org-dir)
  ""
  :type 'directory
  :group 'vonfry-modules)

(custom! +org-agenda-files (append (directory-files +org-agenda-dir t
                                                    "^[A-z0-9\\-_]+\\.org$")
                                   (list +org-capture-file))
  ""
  :type '(repeat file)
  :group 'vonfry-modules
  :custom-set 'org-agenda-files)

(custom! +org-journal-dir (expand-file-name "diary" +org-dir) ""
  :type 'directory
  :group 'vonfry-modules
  :custom-set 'org-journal-dir)

(custom! +org-tags
  (eval (read
    (with-temp-buffer
      (let ((file (expand-file-name ".tags.el" +org-agenda-dir)))
        (when (file-exists-p file)
          (insert-file-contents file)
          (buffer-string))))))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-tag-alist)

(custom! +org-agenda-tags +org-tags ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-tag-alist-for-agenda)

(custom! +org-journal-tags
  (eval (read
    (with-temp-buffer
      (let ((file (expand-file-name ".tags.el" +org-journal-dir)))
        (when (file-exists-p file)
          (insert-file-contents file)
          (buffer-string))))))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-journal-tag-alist)

(custom! +org-note-dir (expand-file-name "notes" +org-dir)
  "org note dir."
  :type 'directory
  :group 'vonfry-modules)

(custom! +org-note-templates-get-location-function
  (lambda (&rest args)
    (interactive)
    (let* ((path (read-file-name "note file: " +org-note-dir)))
           (set-buffer (org-capture-target-buffer path))
           (widen)
           (org-capture-put-target-region-and-position)
           (goto-char (point-max))))
  "location for org diary by org-capture under `+org-diary-dir'."
  :type 'function
  :group 'vonfry-modules)

(custom! +org-todo-keywords-sequence
  '((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-todo-keywords)

(custom! +org-capture-templates
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
     "** %(org-contacts-template-name)\n:PROPERTIES:\n:EMAIL: %(org-contacts-template-email)\s\n:PHONE:\n:ALIAS::NICKNAME:\n:IGNORE:\n:ICON:\n:NOTE:\n:ADDRESS:\n:BIRTHDAY:\n:END:"))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-capture-templates)

(custom! +org-refile-targets
  '((nil :maxlevel 99)
    (+org-projectile-todo-project-file :maxlevel 99)
    (org-contacts-files :maxlevel 99)
    (org-agenda-files :maxlevel . 99))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-refile-targets)

(custom! +org-agenda-custom-commands nil ""
    :type '(choice (const :tag "Disabled" nil)
                   (character)
                   (string))
    :group 'vonfry-modules
    :custom-set 'org-agenda-custom-commands)

(const! +org-roam-local-dir (expand-file-name "org/roam" vonfry-local-dir))

(custom! +org-roam-capture-templates
  '(("d" "default" plain #'org-roam-capture--get-point "%?"
     :file-name "%(+org-roam-capture--note-dir)/${slug}"
     :head "#+title: ${title}"
     :unnarrowed t))
  ""
  :custom-set 'org-roam-capture-templates
  :group 'vonfry-modules
  :type 'sexp)

(custom! +org-roam-capture-immediate-templates
  (append (car +org-roam-capture-templates) '(:immediate-finish t))
  ""
  :custom-set 'org-roam-capture-immediate-template
  :group 'vonfry-modules
  :type 'sexp)

(fun! +org-roam-capture--note-dir ()
  (let ((default-directory +org-note-dir))
    (call-interactively '+org-roam-capture--note-dir-aux)))

(fun! +org-roam-capture--note-dir-aux (path)
  (interactive "Droam: ")
  (let ((path-no-prefix (if (s-prefix? +org-note-dir path)
                            (s-chop-prefixes (list +org-note-dir "/") path)
                          path)))
    (s-chop-suffix "/" path-no-prefix)))

(custom! +org-agenda-ibuffer-group
  `(("Agenda" (or (name .
                        ,(regexp-quote +org-agenda-dir))
                  (name . ,(regexp-quote +org-capture-file)))))
  ""
  :group 'vonfry-modules)

(custom! +org-note-ibuffer-group
  `(("Note" (name . ,(regexp-quote +org-note-dir))))
  ""
  :group 'vonfry-modules)

(custom! +org-journal-ibuffer-group
  `(("Note" (name . ,(regexp-quote +org-journal-dir))))
  ""
  :group 'vonfry-modules)

(custom! +org-ibuffer-group (append +org-agenda-ibuffer-group
                                    +org-note-ibuffer-group
                                    +org-journal-ibuffer-group)
  ""
  :group 'vonfry-modules)

(custom! +org-babel-lang '((emacs-lisp . t)
                           (org        . t)
                           (http       . t)
                           (haskell    . t)
                           (latex      . t)
                           (coq        . t)
                           (R          . t)
                           (sql        . t)
                           (sqlite     . t)
                           (perl       . t)
                           (gnuplot    . t))
  ""
  :group 'vonfry-modules
  :custom-set 'org-babel-load-languages)

(custom! +org-roam-server-port 8100
  ""
  :group 'vonfry-modules
  :custom-set 'org-roam-server-port)

(custom! +org-contacts-dir (expand-file-name "contacts" +org-dir)
  "dir where to save contacts."
  :group 'vonfry-modules
  :type 'directory)
