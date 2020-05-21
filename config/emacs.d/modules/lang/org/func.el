;;; org func -*- lexical-binding: t -*-
;;

(fun! +org--find (path)
  (if (fboundp 'counsel-find-file)
    (counsel-find-file path)
    (let ((default-directory path))
      (call-interactively 'find-file))))

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

(fun! +deft/switch-dir (path)
  (interactive "Ddeft: ")
  (custom-set! deft-directory path))
