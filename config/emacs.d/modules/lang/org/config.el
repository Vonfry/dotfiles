;;; org config -*- lexical-binding: t -*-
;;

;; +mmap-note-def
(mmap-leader-prefix! note "o")

(+mmap-note-def "" '(nil :which-key "note"))

(mmap-mode-prefix! org nil
  :keymaps 'org-mode-map)

(custom! +org-dir (let ((env-orgmode-dir (getenv "ORG_NOTE_DIR")))
                    (if env-orgmode-dir env-orgmode-dir "~/orgmode"))
  "org dir"
  :type 'directory
  :group 'vonfry-modules
  :custom-set 'org-directory)

(custom! +org-agenda-dir (expand-file-name "agenda" +org-dir)
  ""
  :type 'directory
  :group 'vonfry-modules)

(custom! +org-agenda-files (directory-files +org-agenda-dir
                             nil "^[A-z0-9\\-_]\\.org$")
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

(fun! +org--note-templates-get-location (&rest args)
  (funcall +org-diary-templates-get-location-function args)
  "call `+org-note-templates-get-location-function'")

(custom! +org-todo-keywords-sequence
  '((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-todo-keywords)

(custom! +org-capture-file
   (expand-file-name "inbox.org" +org-dir)
   ""
   :type 'file
   :group 'vonfry-modules
   :custom-set 'org-capture-file)

(custom! +org-capture-templates
  (let ((default-templates
          '(("c" "capture to inbox(Tasks), refile later"
             entry (file+headline +org-capture-file "Tasks")
             "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:n"
             :empty-lines 1)
            ("i" "capture to inbox(Idea), refile later"
             entry (file+headline +org-capture-file "Idea")
             "* %?\n:PROPERTIES:\n:CREATED: %Un"
             :empty-lines 1)
            ("n" "capture to note"
             plain (function +org--note-templates-get-location)
             "#+TITLE: %^{title}\n#+DATE: %U\n* Context %^{tags}\n\n* Main Text\n\n%?"
             :empty-lines 1)
            ("j" "Journal entry"
             entry (function +org--journal-find-location)
             "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")
            ("a" "capture to agenda")))
        (agenda-templates
          (-map-indexed
            (lambda (index file-path)
              (let* ((file-name (file-name-nondirectory file-path))
                     (keys (concat "a" (string (+ ?A index)))))
                `(,keys ,(concat "capture to " file-name ", refile later")
                  entry (file ,file-path)
                  "* TODO %?\t\n:PROPERTIES:\n:CREATED: %U\n:END:"
                  :empty-lines 1)))
            +org-agenda-files)))
    (append default-templates agenda-templates))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-capture-templates)

(custom! +org-refile-targets nil ""
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
