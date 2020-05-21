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

(fun! +org/ref-switch (path)
  (interactive "Dorg ref dir: ")
  (custom-set! +org-ref-dir path))
