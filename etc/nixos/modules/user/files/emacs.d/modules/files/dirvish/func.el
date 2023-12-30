;;; dirvish/func.el --- -*- lexical-binding: t -*-

(defun +dired/jump-with-zoxide (&optional other-window)
  (interactive "P")
  (zoxide-open-with nil (lambda (file) (dired-jump other-window file)) t))
