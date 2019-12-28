;;; mail config -*- lexical-binding: t -*-
;;

(custom! +maildir-path "~/.mail"
  "maildir path, see `mu4e-maildir-path'"
  :group 'vonfry-modules
  :type 'directory
  :custom-set 'mu4e-maildir)

(custom! +mail-attachment-dir (expand-file-name "mu4e" vonfry-local-dir)
  "attachment dir, see `mu4e-attachment-dir'"
  :group 'vonfry-modules
  :type 'directory
  :custom-set 'mu4e-attachment-dir)

(custom! +mail-get-mail-command "mbsync -a"
  "get mail command, see `mu4e-get-mail-command'"
  :group 'vonfry-modules
  :type 'string
  :custom-set 'mu4e-get-mail-command)

(custom! +auth-sources '("~/.local/passwd/authinfo.gpg" "~/.authinfo")
  "custom authinfo path, see `auth-sources'"
  :group 'vonfry-modules
  :type '(repeat string)
  :custom-set 'auth-sources)

(custom! +mail-queue-dir  "~/.mail/local/queue/cur"
  "mail queue dir, see `smtpmail-queue-dir'"
  :group 'vonfry-modules
  :type 'directory
  :custom-set 'smtpmail-queue-dir)
