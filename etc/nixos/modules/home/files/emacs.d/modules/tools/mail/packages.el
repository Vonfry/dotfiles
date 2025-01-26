;;; mail/packages.el --- -*- lexical-binding: t -*-
;;

(use-package mu4e
  :ensure nil
  :config
  (load +mail-local-file t t)
  :custom
  (rfc2047-encode-encoded-words nil)
  (mu4e-attachment-dir (xdg-user-dir "DOWNLOAD"))
  (mu4e-get-mail-command "mbsync -a")
  (mail-user-agent 'mu4e-user-agent)
  (mu4e-view-show-addresses t)
  (mu4e-view-prefer-html nil)
  (mu4e-change-filenames-when-moving t)
  (mu4e-update-interval 600)
  (mu4e-headers-skip-duplicates nil)
  (mu4e-sent-messages-behavior 'sent)
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
  (sendmail-program "msmtp")
  (message-send-mail-function 'message-send-mail-with-sendmail)
  (message-sendmail-f-is-evil t)
  (message-sendmail-extra-arguments '("--read-envelope-from" "-t"))
  :hook
  (emacs-startup . (lambda () (when (daemonp) (mu4e t))))
  :config
  (add-to-list 'mu4e-view-actions
               '("View in browser" . mu4e-action-view-in-browser))
  (unless (file-exists-p mu4e-attachment-dir)
    (make-directory mu4e-attachment-dir t))
  (nmap-at
    "@" 'mu4e))

(use-package mu4e-alert
  :after mu4e
  :config
  (mu4e-alert-enable-mode-line-display)
  (mu4e-alert-set-default-style 'libnotify)
  (mu4e-alert-enable-notifications))
