;;; gnus config -*- lexical-binding: t -*-
;;

(custom! +gnus-local-file (expand-file-name "gnus.el" vonfry-local-dir)
  "A local file for gnus private config is loaded automaticly, which can be
 missing."
  :type 'file
  :group 'vonfry-modules)

(custom! +auth-sources '("~/.local/passwd/authinfo.gpg" "~/.authinfo")
  ""
  :group 'vonfry-modules
  :type '(repeat string)
  :custom-set 'auth-sources)

(custom! +smtp-accounts '()
  "smtp accounts. A list contains lists, which should be (`user-mail-address'
`user-full-name' `smtpmail-smtp-server' `smtpmail-smtp-service'
`smtpmail-smtp-user')"
  :type '(list (list string string string integer string))
  :group 'vonfry-modules)

(custom! +gnus-desktop-notify-command
  (vonfry-system-sets
    (darwin
      (s-join " "
        '("terminal-notifier"
          "-title \"New mail\""
          "-group Emacs"
          "-contentImage"
          "/usr/local/opt/emacs-mac/share/icons/hicolor/32x32/apps/emacs.png"
          "-message")))
    (gnu/linux
      (s-join " "
        '("notify-send"
          "--"
          "\"New mail\""))))
  "command to notify"
  :group 'vonfry-module
  :type 'string
  :custom-set 'gnus-desktop-notify-exec-program)

(custom! +mail-sync-idle '(5 5)
  "mail sync idle, see more: `gnus-demon-add-handler'"
  :type '(list integer integer)
  :group 'vonfry-modules)

(custom! +mail-sync-command "mbsync -a"
  "sync command"
  :type 'string
  :group 'vonfry-modules)

(fun! +smtp--set (x)
  (eval `(custom-set! user-mail-address     ,(nth x 0)
                      user-full-name        ,(nth x 1)
                      smtpmail-smtp-server  ,(nth x 2)
                      smtpmail-smtp-service ,(nth x 3)
                      smtpmail-smtp-user    ,(nth x 4))))


(fun! +smtp*compose (&rest args)
  (call-interactively '+smtp/switch))
