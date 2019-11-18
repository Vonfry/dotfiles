;;; core/core-keybinding.el -*- lexical-binding: t -*-
;;
;; This file doesn't set a lot of keybindinds, because the plugins are setting in modules and they cannot be set here.
;; If using hooks, I think it isn't beautiful enough. So the file only defines some keys which are bounded to use.
;;
;; The name with evil means that the keybind use with <leader> in evil-normal. I don't use `general-default-prefix` to
;; set leader because there are some normal bind without leader.
;;
;; All local map set for major or minor mode map by default. Only if the minor mode hasn't a map, such as robe, using
;; evil minor mode map instead which use a hook to add into local map.
;; All keybind use general.el to manage.
;;
;; The only one you can customize is leader key. The others are the public key using whole space.
;; All keys combine with leader when setting, this can have a more structed definitation.

(defcustom vonfry-keybind-evil-leader "SPC"
  "Leader key"
  :type 'string
  :set
  (lambda (sym newvalue)
    (defconst +nmap-leader newvalue "leader key")
    (set-default sym newvalue))
  :group 'vonfry-keybind)

(defconst +nmap-lang "z"
  "lang configure")

(defmacro vonfry-def-map-prefix (states name keys &rest args)
  "Define a key definer with prefix.\nNote: the second argument will be evaled, so expression can be passed here."
  (let ((name-with (make-symbol (format "%s-def" (symbol-name name)))))
    `(general-create-definer ,name-with :prefix ,(eval keys) :states ,states ,@args)))

(defmacro vonfry-def-nmap-prefix (name keys &rest args)
  "Define a key definer with prefix.\nNote: the second argument will be evaled, so expression can be passed here."
  (let ((name-with (make-symbol (format "+nmap-%s" (symbol-name name)))))
    `(vonfry-def-map-prefix 'normal ,name-with ,(eval keys)  ,@args)))

(defmacro vonfry-def-nmap-leader-prefix (name keys &rest args)
  "Define a key definer with leader prefix.\nNote: the second argument will be evaled, so expression can be passed here. Pass `nil' to generate for leader prefix."
  (let ((key-with (concat +nmap-leader " " (eval keys))))
    `(vonfry-def-nmap-prefix ,name ,key-with ,@args)))

(defmacro vonfry-def-nmap-lang-prefix (name keys &rest args)
  "Define a key definer with leader lang prefix.\nPass `nil' to second argument to generate for lang prefix."
  (let ((name-with (make-symbol (format "lang-%s" (symbol-name name))))
        (key-with (concat +nmap-lang " " keys)))
    `(vonfry-def-nmap-leader-prefix ,name-with ,key-with ,@args)))

(defmacro vonfry-def-vmap-prefix (name keys &rest args)
  "Define a key definer with prefix.\nNote: the second argument will be evaled, so expression can be passed here."
  (let ((name-with (make-symbol (format "+vmap-%s" (symbol-name name)))))
    `(vonfry-def-map-prefix 'visual ,name-with ,(eval keys) ,@args)))

(defmacro vonfry-def-vmap-leader-prefix (name keys &rest args)
  "Define a key definer with leader prefix.\nNote: the second argument will be evaled, so expression can be passed here. Pass `nil' to generate for leader prefix."
  (let ((key-with (concat +nmap-leader " " (eval keys))))
    `(vonfry-def-vmap-prefix ,name ,key-with ,@args)))

(defmacro vonfry-def-vmap-lang-prefix (name keys &rest args)
  "Define a key definer with leader lang prefix.\nPass `nil' to second argument to generate for lang prefix."
  (let ((name-with (make-symbol (format "lang-%s" (symbol-name name))))
        (key-with (concat +nmap-lang " " keys)))
    `(vonfry-def-vmap-leader-prefix ,name-with ,key-with ,@args)))

(package! general
  :custom
  (general-default-prefix       nil)
  (general-vim-definer-default 'states)
  :config
  (general-evil-setup t t)
  ;; +nmap-leader-def
  (vonfry-def-nmap-prefix leader +nmap-leader))

(provide 'core-keybinding)
