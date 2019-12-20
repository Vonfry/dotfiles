;;; mail packages -*- lexical-binding: t -*-
;;
(straight-override-recipe
  '(apel :host github :repo "wanderlust/apel" :branch "apel-wl"))
(straight-override-recipe
  '(semi :host github :repo "wanderlust/semi" :branch "semi-1_14-wl"))
(straight-override-recipe
  '(flim :host github :repo "wanderlust/flim" :branch "flim-1_14-wl"
         :files ("*.texi" "*.el" (:exclude "md5-dl.el"
                 "md5-el.el" "mel-b-dl.el" "sha1-dl.el"
                 "smtpmail.el") "flim-pkg.el")))
(package! wl
  :straight wanderlust
  :config
  (if +mail-local-config-file
    (load +mail-local-config-file t t)
    nil))
