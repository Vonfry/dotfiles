;;; zoxide func -*- lexical-binding: t -*-
;;

(defun +zoxide-fzf ()
  (interactive)
  (let ((zoxide-find-file-function #'consult-find))
    (zoxide-find-file)))
