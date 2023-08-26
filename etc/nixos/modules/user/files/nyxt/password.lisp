(in-package #:nyxt-user)

(define-configuration nyxt/mode/password:password-mode
  ((nyxt/mode/password:password-interface
    (make-instance 'password:password-store-interface))))

(define-configuration web-buffer
  ((default-modes (pushnew 'nyxt/mode/password:password-mode %slot-value%))))

(define-configuration document-mode
  ((keyscheme-map
    (define-keyscheme-map "password-map"
        (list :import %slot-value%)
         nyxt/keyscheme:vi-normal
         (list "a u" 'copy-username
               "a p" 'copy-password)))))
