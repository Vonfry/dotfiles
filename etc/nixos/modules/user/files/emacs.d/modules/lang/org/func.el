;;; org/func.el --- -*- lexical-binding: t -*-
;;

(defun +org--find (path)
  (consult-find path))

(defun +org/find-agenda ()
  (interactive)
  (+org--find +org-agenda-dir))

(defun +org/find-notes ()
  (interactive)
  (+org--find +org-note-dir))

(defun +org/find-contacts ()
  (interactive)
  (+org--find +org-contacts-dir))

(defun +org/open-capture ()
  (interactive)
  (find-file +org-capture-file))

(defun +org/ql-notes (query)
  "`org-ql-search' in `+org-note-dir' recursively with QUERY."
  (interactive "squery: ")
  (org-ql-search
    (org-ql-search-directories-files
     :directories (list +org-note-dir)
     :recurse t)
    query
    :title "Query Notes"))

(defun +org/ql-notes-backlinks (query)
  "Search QUERY in linking content.

QUERY is the link content.  When calling interactively, it is read at current
point.  You can also use prefix arg to query file instead of current headline.

For performance reason, regexp doesn't support in this function.
Please use `+org/ql-notes' manually."
  (interactive (list (+org--notes-get-link-search current-prefix-arg)))
  (+org/ql-notes `(link ,query)))

(defun +org--notes-get-link-search (&optional file?)
  "Get search content for link in `+org-note-dir' at current link point.

If FILE? is non-nil, it will search filename only."
  (let* ((link-block (substring-no-properties (org-store-link nil nil)))
         (elements (org-element-parse-secondary-string link-block '(link)))
         (link-props (cadr (car elements)))
         (filepath (file-relative-name
                    (plist-get link-props :path)
                    +org-note-dir))
         (opt (plist-get link-props :search-option))
         (opt-str (if (or file? (not opt) (string-empty-p opt))
                      ""
                    (format "::%s" opt))))
    (format "%s%s" filepath opt-str)))
