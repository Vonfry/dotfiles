;;; im func -*- lexical-binding: t -*-
;;

(defun +irc/connect ()
  "connect to server"
  (interactive)
  (let* ((read-alist (-map (lambda (l)
                      `(,(concat (plist-get l :server)
                                 "(" (plist-get l :nick) ")")
                        ,@l))
                           +irc-connect-list))
         (selection (completing-read "server: " read-alist nil t))
         (sel-val (cdr (assoc selection read-alist))))
    (apply 'erc-tls sel-val)))
