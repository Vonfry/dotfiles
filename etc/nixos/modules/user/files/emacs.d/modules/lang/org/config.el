;;; org config -*- lexical-binding: t -*-
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

(defun +org--note-templates-get-location (&rest args)
  "location for org diary by org-capture under `+org-diary-dir'."
  (interactive)
  (let* ((path (read-file-name "note file: " +org-note-dir)))
    (set-buffer (org-capture-target-buffer path))
    (widen)
    (org-capture-put-target-region-and-position)
    (goto-char (point-max))))

(defconst +org-roam-local-dir (expand-file-name "org/roam" vonfry-local-dir))

(defun +org--roam-set-path (path)
  (setq-default
   org-roam-directory path
   org-roam-db-location (expand-file-name
                         (replace-regexp-in-string
                          "/" "!"
                          path)
                         +org-roam-local-dir)))

(defconst +org--agenda-ibuffer-group
  `(("Agenda" (or (name . ,(regexp-quote +org-agenda-dir))
                  (name . ,(regexp-quote +org-capture-file))))))

(defconst +org--note-ibuffer-group
  `(("Note" (name . ,(regexp-quote +org-note-dir)))))

(defconst +org--journal-ibuffer-group
  `(("Journal" (name . ,(regexp-quote +org-journal-dir)))))

(defconst +org--ibuffer-group (append +org--agenda-ibuffer-group
                                      +org--note-ibuffer-group
                                      +org--journal-ibuffer-group))

(defconst +org-contacts-dir (expand-file-name "contacts" +org-dir)
  "dir where to save contacts.")

(defun +org--auto-mode-to-file-apps (mode cmd)
  (when (and mode cmd)
    (let* ((modes (--filter (equal mode (cdr it)) auto-mode-alist))
           (regs (--map (car it) modes)))
      (--map (cons it cmd) regs))))
