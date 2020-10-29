;;; dashboard func -*- lexical-binding: t -*-
;;
(defun +dashboard/goto ()
  (interactive)
  (switch-to-buffer "*dashboard*")
  (+dashboard/set-fortune)
  (dashboard-refresh-buffer))

(defun +dashboard/set-fortune ()
  (interactive)
  (setq dashboard-footer-messages
        (list
         (replace-regexp-in-string
          (rx (+ (| (| space blank) "\n")))
          " "
          (replace-regexp-in-string
           (concat (string 27) "\\[[0-9;]*[A-z]" (string 29) "?")
           ""
           (shell-command-to-string "fortune -s $CLONE_LIB/fortunes/data all"))))))
