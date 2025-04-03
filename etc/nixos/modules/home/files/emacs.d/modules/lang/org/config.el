;;; org/config.el --- -*- lexical-binding: t -*-
;;

(defcustom +org-dir (if-let* ((env-orgmode-dir (getenv "ORGMODE_DIR")))
                        env-orgmode-dir
                      "~/orgmode")
  "org dir"
  :type 'directory
  :group 'vonfry-modules)

(defconst +org-capture-file (expand-file-name "inbox.org" +org-dir))

(defconst +org-agenda-dir (expand-file-name "agenda" +org-dir))

(defconst +org-note-dir (expand-file-name "notes" +org-dir)
  "org note dir.")

(defconst +org-journal-dir (expand-file-name "diary" +org-dir))

(defconst +org-contacts-dir (expand-file-name "contacts" +org-dir)
  "dir where to save contacts.")

(defun +org--refile-new-note (&optional slug)
  "Get a new note file path in `+org-note-dir' with current time and SLUG."
  (let* ((date (format-time-string "%Y%m%d%H%M%S" (current-time)))
         (slug (if slug slug (read-string "slug: ")))
         (filename (format "%s-%s.org" date slug))
         (filepath (expand-file-name filename +org-note-dir)))
    (set-buffer (org-capture-target-buffer filepath))))
