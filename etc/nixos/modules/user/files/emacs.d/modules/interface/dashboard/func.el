;;; dashboard/func.el --- -*- lexical-binding: t -*-
;;

(defun +dashboard/goto (&optional new)
  (interactive "P")
  (switch-to-buffer "*dashboard*")
  (when new
    (+dashboard/set-fortune))
  (cd +dashboard-pwd)
  (dashboard-refresh-buffer))

(defun +dashboard--init ()
  (+dashboard/goto t))

(defun +dashboard/set-fortune ()
  (interactive)
  (when (executable-find "fortune")
    (setq dashboard-footer-messages
          (list
           (replace-regexp-in-string
            (rx (+ (| (| space blank) "\n")))
            " "
            (replace-regexp-in-string
             (rx 27 "[" (* (| digit ";")) alpha (? 29))
             ""
             (shell-command-to-string
              (format "fortune -s %s all"
                      (expand-file-name "fortunes" (xdg-data-home))))))))))
