;;; mail packages -*- lexical-binding: t -*-
;;

(package! mu4e
  :ensure nil
  :load-path
  (lambda ()
    (vonfry-system-sets (darwin "/usr/local/share/emacs/site-lisp/mu/mu4e")))
  :custom
  (mail-user-agent 'mu4e-user-agent)
; (mu4e-maildir +maildir-path)
  (mu4e-view-show-addresses t)
; (mu4e-get-mail-command +mail-get-mail-command)
  (mu4e-update-interval 300)
; (mu4e-attachment-dir +mail-attachment-dir)
  (mu4e-sent-folder   "/local/sent")
  (mu4e-trash-folder  "/local/trash")
  (mu4e-refire-folder "/local/archive")
  (mu4e-drafts-folder "/local/drafts")
  (mu4e-headers-fields
          '((:human-date     .  16)
			(:flags          .   4)
			(:from           .  22)
			(:maildir        .  16)
			(:thread-subject .  nil)))
  (mu4e-view-show-adresses t)
  :hook
  ((mu4e-header mu4e-compose mu4e-main mu4e-org mu4e-view) .
    (lambda () (custom-set-variable 'show-trailing-whitespace nil)))
  :config
  (unless (file-exists-p mu4e-attachment-dir)
    (make-directory mu4e-attachment-dir t))
  :general
  (+mmap-at-def
    "m" 'mu4e))

(package! auth-source
  :ensure nil
; :custom
; (auth-sources +auth-sources)
)

(package! smtpmail
  :ensure nil
  :custom
  (smtpmail-stream-type 'starttls)
  (starttls-use-gnutls  t)
; (smtpmail-queue-dir +mail-queue-dir)
  (send-mail-function 'smtpmail-send-it)
  (message-send-mail-function 'smtpmail-send-it))

(package! mu4e-alert
  :after mu4e
  :hook
  (after-init .
    (lambda ()
      (mu4e-alert-enable-mode-line-display)
      (vonfry-system-sets (gnu/linux (mu4e-alert-set-default-style 'libnotify))
                          (darwin (mu4e-alert-set-default-style 'growl)))
      (mu4e-alert-enable-notifications))))

(package! mu4e-maildirs-extension
  :after mu4e-vars
  :config
  (mu4e-maildirs-extension))
