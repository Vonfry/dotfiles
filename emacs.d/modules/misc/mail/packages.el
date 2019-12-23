;;; mail packages -*- lexical-binding: t -*-
;;

(package! mu4e
  :custom
	(mail-user-agent 'mu4e-user-agent)
	(mu4e-maildir +maildir-path)
    (mu4e-view-show-addresses t)
	(mu4e-get-mail-command +mail-get-mail-command)
	(mu4e-update-interval 300)
	(mu4e-attachment-dir +mail-attachment-dir)
	(mu4e-sent-folder "/local/sent")
	(mu4e-trash-folder "/local/trash")
	(mu4e-refire-folder "/local/archive")
	(mu4e-drafts-folder "/local/drafts")
  (mu4e-headers-fields
          '((:human-date     .  16)
			(:flags          .   4)
			(:from           .  22)
			(:maildir        .  16)
			(:thread-subject .  nil)))
  (mu4e-view-show-adresses t)
  :general
  (+mmap-at-def
    "m" 'mu4e))

(package! auth-source
  :custom
  (auth-sources +auth-sources))

(package! smtpmail
  :custom
  (smtpmail-stream-type 'starttls)
  (starttls-use-gnutls  t)
  (smtpmail-queue-dir +mail-queue-dir)
  (send-mail-function 'smtpmail-send-it)
  (message-send-mail-function 'smtpmail-send-it))

(package! mu4e-alert
  :after mu4e)

(package! mu4e-maildirs-extension
  :after mu4e-vars
  :config
  (mu4e-maildirs-extension))
