;;; dashboard func -*- lexical-binding: t -*-
;;
(defun +dashboard-goto ()
  (interactive)
  (switch-to-buffer "*dashboard*")
  (dashboard-refresh-buffer))
