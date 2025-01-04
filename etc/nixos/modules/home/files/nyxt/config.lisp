(in-package #:nyxt-user)

(define-nyxt-user-system-and-load nyxt-user/basic-config
  :components ("general" "keybindings" "stylesheet" "engines" "password"))

(defconstant vonfry-custom-dir
  (files:resolve (files:profile *config-file*)
                 (make-instance 'config-directory-file :base-path #p"local")))

(defconstant vonfry-custom-file
  (uiop:merge-pathnames* "config.lisp" vonfry-custom-dir))

(when (uiop:file-exists-p vonfry-custom-file)
  (defmacro vonfry-custom-define-system-load-components (name &rest components)
    `(define-nyxt-user-system-and-load
         ,(intern (str:concat "NYXT-USER/CUSTOM-CONFIG-" (string name)))
       :config-directory ,vonfry-custom-dir
       :components ,components))
  (load vonfry-custom-file :verbose t))
