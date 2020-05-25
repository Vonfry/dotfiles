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

(fun! +smtp--set (x)
  (eval `(custom-set! user-mail-address     ,(nth x 0)
                      user-full-name        ,(nth x 1)
                      smtpmail-smtp-server  ,(nth x 2)
                      smtpmail-smtp-service ,(nth x 3)
                      smtpmail-smtp-user    ,(nth x 4))))


(fun! +smtp*compose (&rest args)
  (call-interactively '+smtp/switch))
