;;; mail config -*- lexical-binding: t -*-
;;

(defcustom +maildir-path "~/.mail"
  "maildir path, see `mu4e-maildir-path'"
  :group 'vonfry-modules
  :type 'directory)

(defcustom +mail-attachment-dir (expand-file-name "mu4e" vonfry-local-dir)
  "attachment dir, see `mu4e-attachment-dir'"
  :group 'vonfry-modules
  :type 'directory)

(defcustom +mail-get-mail-command "mbsync -a"
  "get mail command, see `mu4e-get-mail-command'"
  :group 'vonfry-modules
  :type 'string)

(defcustom +auth-sources '("~/.local/passwd/authinfo.gpg" "~/.authinfo")
  "custom authinfo path, see `auth-sources'"
  :group 'vonfry-modules
  :type '(repeat string))

(defcustom +mail-queue-dir  "~/.mail/local/queue/cur"
  "mail queue dir, see `smtpmail-queue-dir'"
  :group 'vonfry-modules
  :type 'directory)
