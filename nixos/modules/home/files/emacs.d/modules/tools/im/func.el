;;; im/func.el --- -*- lexical-binding: t -*-
;;

(defun +irc/connect ()
  "Connect to irc server."
  (interactive)
  (let* ((read-alist (mapcar (lambda (l)
                      `(,(concat (plist-get l :server)
                                 "(" (plist-get l :nick) ")")
                        ,@l))
                           +irc-connect-list))
         (selection (completing-read "server: " read-alist nil t))
         (sel-val (cdr (assoc selection read-alist))))
    (apply 'erc-tls sel-val)))
