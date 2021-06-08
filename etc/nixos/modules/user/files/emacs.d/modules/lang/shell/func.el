;;; shell func -*- lexical-binding: t -*-
;;

(defun +shell/open-term-at-pwd ()
  (interactive)
  (let* ((pwd (projectile-project-root))
         (pwd (if pwd pwd default-directory))
         (cmd (concat +shell-terminal-command
                      " "
                      +shell-terminal-extra-arguments))
         (args (concat +shell-terminal-args-pwd
                       " "
                       pwd)))
    (start-process
     (concat "*terminal: " pwd "*")
     nil cmd args)))

(defun +shell/open-file-manager-x ()
  (interactive)
  (start-process
   (concat "*file-manager: " (pwd) "*")
   nil "xdg-open" "."))
