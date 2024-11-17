;;; org/config.el --- -*- lexical-binding: t -*-
;;

(defcustom +org-dir (let ((env-orgmode-dir (getenv "ORG_DIR")))
                      (if env-orgmode-dir env-orgmode-dir "~/orgmode"))
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

(defun +org--auto-mode-to-file-apps (mode cmd)
  (when (and mode cmd)
    (let* ((modes (seq-filter (lambda (it) (equal mode (cdr it)))
                              auto-mode-alist))
           (regs (mapcar #'car modes)))
      (mapcar (lambda (it) (cons it cmd)) regs))))

(defun +org--refile-new-note (&optional slug)
  "Get a new note file path in `+org-note-dir' with current time and SLUG."
  (let* ((date (format-time-string "%Y%m%d%H%M%S" (current-time)))
         (slug (if slug slug (read-string "slug: ")))
         (filename (format "%s-%s.org" date slug)))
    (find-file (expand-file-name filename +org-note-dir))))
