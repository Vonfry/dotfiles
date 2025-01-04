;;; avy/func.el --- -*- lexical-binding: t -*-
;;

(defun +ace/append (start end)
  (interactive
    (list (region-beginning) (region-end)))
  (let ((count (length (window-list))))
    (when (> count 1)
      (let* ((next (next-window))
             (window
                (if (> count 2)
                  (ace-window 'other-window)
                  (progn (other-window 0)
                         next)))
             (buffer (window-buffer window)))
        (append-to-buffer buffer start end)))))

(defun +ace/append-point ()
  "Append from begin to point into buffer"
  (interactive)
  (let ((start (point-min))
        (end (point)))
    (+ace/append start end)))
