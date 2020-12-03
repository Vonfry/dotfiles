;;; dashboard func -*- lexical-binding: t -*-
;;

(defun +dashboard/goto (&optional newFortune)
  (interactive "P")
  (switch-to-buffer "*dashboard*")
  (when newFortune
    (+dashboard/set-fortune))
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
           (shell-command-to-string
            (s-join " "
                    (list "fortune"
                          "-s"
                          (expand-file-name "fortunes" (xdg-data-home))
                          "all"))))))))
