;;; core/core-packages.el -*- lexical-binding: t; -*-
;;
;; Define packages manager with use-package.
;;
;; All modules save in format modules/submodule, the submodule in different module can have the same name. In a
;; submodule, config.el, packages.el and func.el file can be loaded automatically by the writting order. The other file
;; should be loaded in these file or by yourself.
;; config.el define custom, const and other varible for configure.
;; packages.el define the dependence and default configure with `package!'
;; func.el define autoload funciotns which is suggested to saved under a dir named autoload.
;;
;; use-package provide a tools that download a package if it isn't installed.;;

;; define some variables for packages
;;
;; Use `custom-set!` everywhere to config the varibles with defcustom. Only use `setq` somewhere the variables
;; are temporary such as debug configure.
;; Because `custom-set!` contains a lot of other behaviors such as set-after.
;;

(defun vonfry--plist-delete (plist property)
  "A copy from `org-plist-delete'."
  (let (p)
    (while plist
      (if (not (eq property (car plist)))
        (setq p (plist-put p (car plist) (cadr plist))))
      (setq plist (cddr plist)))
    p))

(defcustom vonfry-exclude-modules '()
  "This variables is used to the arguments for `vonfry-load-modules`"
  :type '(repeat string)
  :group 'vonfry)

(defconst vonfry-modules-dir (expand-file-name "modules/" vonfry-config-dir))

(custom-set-variables
  '(use-package-always-demand t)
  '(use-package-always-ensure nil))

;;
;; define some basic packages
;;

(defcustom vonfry-basic-packages '(
    use-package
    ;; many package load org directly without eval-after-load, so add it here
    ;; to make sure the newest is used.
    org
  )
  "These are the default basic packages, which are used by modules."
  :type '(repeat symbol)
  :group 'vonfry)

;; load the basic packages
(dolist (pkg vonfry-basic-packages)
  (let ((qpkg `(quote ,pkg)))
    (eval `(require ,qpkg))))

(defalias #'package! #'use-package)

(package! diminish)
(package! dash)
(package! s)

(defun autoload! (func file &optional interactive docstring type)
  "autoload file with current load file dir which is called in submodules.
Note: the &optional arguments has some different from `autoload`."
  (let* ((current-dir (file-name-directory load-file-name))
         (autoload-dir (expand-file-name "autoload" current-dir))
         (autoload-file (expand-file-name file autoload-dir)))
    (autoload func autoload-file docstring interactive type)))

(defun vonfry-load-module (module-name file)
  "This function load a module with two level name.

module: The category of a module. It is the dir-name under modules.
submodule: The name of a module. It is the dir-name under a module dir.

This function finds module with the file, and loads it."

  (let* ((module-dir (expand-file-name module-name vonfry-modules-dir))
         (file-path (expand-file-name file module-dir)))
    (load file-path t t)))

(defun vonfry-load-module-packages (module-name)
  (vonfry-load-module module-name "packages"))

(defun vonfry-load-module-config (module-name)
  (vonfry-load-module module-name "config"))

(defun vonfry-load-autoload (module-name)
  (vonfry-load-module module-name "func"))

(defun vonfry-load-modules (&rest exclude)
  "This function load all modules exclude the modules/submodule(i.e. lang/haskell) name in arguments.

All modules should use function and macro in this file. By default, every modules should have a file named packages.el which is used to define the dependence with `package!`. This file will be loaded at first for each modules. After all modules' packages.el are loaded, it will load config.el which is used to configure for the module which is the main file for a module.  Finally, the autoload.el will be loaded. It used to load some function for the modules."
  (let* ((module-list '())
         (regexp-match "^[^\\.].*"))
    (dolist (module (directory-files vonfry-modules-dir nil regexp-match))
        (dolist (submodule (directory-files (expand-file-name module vonfry-modules-dir) nil regexp-match))
          (let ((module-name (concat module "/" submodule)))
            (unless (member module-name exclude))
              (push module-name module-list))))
    (-map 'vonfry-load-module-config   module-list)
    (-map 'vonfry-load-module-packages module-list)
    (-map 'vonfry-load-autoload        module-list)))

(defmacro custom! (varname form docstring &rest args)
  "This macro is used for `defcustom' :set param. Make it easy to config other variable by using keyword :custom-set."
  (let* ((custom-set (plist-get args :custom-set))
         (args (vonfry--plist-delete args :custom-set))
         (custom-form (when custom-set
                       `(lambda (name value)
                          (set-default name value)
                          (let ((varname ,custom-set))
                            (custom-set-variables `(,varname ',value))))))
         (docstring (if custom-form
                      (let ((docsep (if (< 0 (string-width docstring)) "\n" "")))
                        (concat "See: `"
                                (symbol-name (cadr custom-set))
                                "'"
                                docsep
                                docstring))
                      docstring)))
    `(defcustom ,varname ,form ,docstring :set ,custom-form ,@args)))

(defalias #'fun!   #'defun)
(defalias #'var!   #'defvar)
(defalias #'const! #'defconst)
(defalias #'macro! #'defmarco)
(defalias #'alias! #'defalias)

(defmacro hook! (hook func &rest args)
  (let ((body (cond ((listp func) `(lambda () (,@func)))
                    (t func))))
  `(apply 'hook~! '(,hook (,@body) ,@args))))

(defun hook~! (hook &rest args)
  (apply 'add-hook
         (intern (concat (symbol-name hook) "-hook"))
         args))

(defmacro custom-set! (&rest plist)
  `(custom-set-variables
     ,@(-map (lambda (item)
              `(quote ,item))
             (-partition 2 plist))))

(defmacro after! (feature &rest body)
  `(with-eval-after-load ',feature ,@body))

(provide 'vonfry-packages)
