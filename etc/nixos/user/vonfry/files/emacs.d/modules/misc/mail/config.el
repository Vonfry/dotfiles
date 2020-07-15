;;; mail config -*- lexical-binding: t -*-
;;

(custom! +maildir-path "~/.mail"
  ""
  :group 'vonfry-modules
  :type 'directory
  :custom-set 'mu4e-maildir)

(custom! +mail-attachment-dir (expand-file-name "attach" vonfry-local-dir)
  ""
  :group 'vonfry-modules
  :type 'directory
  :custom-set 'mu4e-attachment-dir)

(custom! +mail-get-mail-command "mbsync -a"
  ""
  :group 'vonfry-modules
  :type 'string
  :custom-set 'mu4e-get-mail-command)

(custom! +auth-sources '("~/.local/passwd/authinfo.gpg" "~/.authinfo")
  ""
  :group 'vonfry-modules
  :type '(repeat string)
  :custom-set 'auth-sources)

(custom! +mail-queue-dir  "~/.mail/local/queue/cur"
  ""
  :group 'vonfry-modules
  :type 'directory
  :custom-set 'smtpmail-queue-dir)

(custom! +mail-local-file (expand-file-name "mail.el" vonfry-local-dir)
  "A local config for mail, loads by `load'. It can be missing. "
  :type 'file
  :group 'vonfry-modules)
