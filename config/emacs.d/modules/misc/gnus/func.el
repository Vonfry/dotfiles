;;; gnus func -*- lexical-binding: t -*-
;;

(fun! +mail/sync ()
  (interactive)
  (start-process-shell-command
    "*mail-sync*" "*mail-sync*"
    +mail-sync-command))

(fun! +smtp/switch ()
  (interactive)
  (when (> (length +smtp-accounts) 1)
    (if (fboundp 'ivy-read)
      (ivy-read "smtp: "
        (--map `(,(car it) ,@it) +smtp-accounts)
        :require-match t
        :action
        (lambda (alist) (+smtp--set (cdr alist))))
      (message "not support"))))
