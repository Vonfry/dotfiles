;;; irc func -*- lexical-binding: t -*-
;;

(defun +irc/connect ()
  "connect to server"
  (interactive)
  (if (fboundp 'ivy-read)
    (ivy-read "server: "
              (-map (lambda (l)
                      `(,(concat (plist-get l :server)
                                 "(" (plist-get l :nick) ")")
                        ,@l))
                    +irc-connect-list)
              :require-match t
              :action
              (lambda (c)
                (eval `(erc-tls ,@(cdr c)))))
    (message "not support")))
