(defun insert-current-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S +0800")))

(provide 'init-func)
