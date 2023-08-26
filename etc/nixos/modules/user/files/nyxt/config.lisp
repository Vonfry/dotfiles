(in-package #:nyxt-user)

(define-nyxt-user-system-and-load nyxt-user/basic-config
    :components ("general" "keybindings" "stylesheet" "engines" "password"))

; (define-nyxt-user-system-and-load nyxt-user/local-config
;     :pathname "local"
;     :components ("config"))
