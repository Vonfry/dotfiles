;;; autoload - func -*- lexical-binding: -*-

(unless (string-match "fish" (getenv "SHELL"))
  (package! exec-path-from-shell)
  (use-package! exec-path-from-shell
  :config
    (exec-path-from-shell-initialize)))

(defun vonfry/insert-current-date ()
    (interactive)
    (insert (format-time-string "%Y-%m-%d %H:%M:%S +0800")))
