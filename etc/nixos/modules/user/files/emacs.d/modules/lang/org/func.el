;;; org func -*- lexical-binding: t -*-
;;

(fun! +org--find (path)
  (cond ((and (executable-find "fzf")
              (fboundp 'counsel-fzf))
         (counsel-fzf nil path))
        ((fboundp 'counsel-find-file)
         (counsel-find-file path))
        (t (let ((default-directory path))
             (call-interactively 'find-file)))))

(fun! +org/find-agenda ()
  (interactive)
  (+org--find +org-agenda-dir))

(fun! +org/append-to-agenda-file ()
  (interactive)
  (let ((default-directory +org-agenda-dir))
    (call-interactively 'append-to-file)))

(fun! +org/find-notes ()
  (interactive)
  (+org--find +org-note-dir))

(fun! +org/find-contacts ()
  (interactive)
  (+org--find +org-contacts-dir))

(fun! +org/roam-switch (path)
  "A path is a roam."
  (interactive "Droam: ")
  (eval `(custom-set! org-roam-directory ,path
                      org-roam-db-location
                      (expand-file-name
                          (replace-regexp-in-string
                          "/" "!"
                          ,path)
                          +org-roam-local-dir))))
