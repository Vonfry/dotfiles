;;; shell func -*- lexical-binding: t -*-
;;

(fun! +shell-open-term-at-pwd ()
  (interactive)
  (let* ((pwd (projectile-project-root))
         (pwd (if pwd pwd default-directory))
         (cmd (concat +shell-terminal-command
                      " "
                      +shell-terminal-extra-arguments))
         (args (concat +shell-terminal-args-pwd
                       " "
                       pwd)))
    (start-process-shell-command
      (concat "*terminal: " pwd "*")
      nil nil
      cmd args)))
