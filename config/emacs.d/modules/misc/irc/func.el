;;; irc func -*- lexical-binding: t -*-
;;

(fun! +irc/connect ()
  "connect to server"
  (interactive)
  (if (fboundp 'ivy-read)
    (ivy-read "server: "
              (-map (lambda (l)
                      `(,(concat (plist-get l :nick)
                                 " >> "
                                 (plist-get l :server))
                        ,@l))
                    +irc-connect-list)
              :require-match t
              :action
              (lambda (c)
                (eval `(erc-tls ,@(cdr c)))))
    (message "not support")))
