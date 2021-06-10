;;; shell func -*- lexical-binding: t -*-
;;

(defun +shell/open-term-at-pwd ()
  (interactive)
  (let* ((projdir (projectile-project-root))
         (pwd (if projdir projdir default-directory))
         (cmd +shell-terminal-command)
         (args (-non-nil
                (list +shell-terminal-extra-arguments
                      +shell-terminal-args-pwd
                      pwd))))
    (apply 'start-process
           (concat "*terminal: " pwd "*")
           nil cmd args)))

(defun +shell/open-file-manager-x ()
  (interactive)
  (let* ((projdir (projectile-project-root))
         (pwd (if projdir projdir default-directory))
         (cmd +shell-terminal-command)
         (args (-non-nil
                (list +shell-file-manager-args-pwd
                      pwd))))
  (apply 'start-process
         (concat "*file-manager: " pwd "*")
         nil +shell-file-manager-command args)))
