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
  :custom
  (elmo-localdir-folder-path "~/.mail")
  (elmo-cache-directory "~/.mail/cache")
  (wl-default-folder ".~/.mail/INBOX")
  (wl-draft-folder   ".~/.mail/draft")
  (wl-trash-folder   ".~/.mail/trash")
  (wl-queue-folder   ".~/.mail/queue")
  (wl-temporary-file-directory "~/.mail/tmp")
	(wl-init-file (expand-file-name "dotfiles/emacs/wl/wl" (getenv "CLOUDDISK_DIR")))
  (wl-folders-file (expand-file-name "dotfiles/emacs/wl/folders" (getenv "CLOUDDISK_DIR")))
  (wl-forward-subject-prefix "Fwd: ")
  (elmo-message-ignored-field-list '(".*"))
  (elmo-message-visible-field-list '("^From.*" "^Cc.*" "^Subject.*" "^To.*"
                                     "^Bcc.*" "^Fcc.*" "^Reply-To.*"
                                     "^List-Archive.*" "^Delivered-To.*"))
  :hook
  (evil-after-load . (lambda ()
    (let ((modes '(wl-folder-mode wl-summary-mode)))
      (dolist (m modes)
        (evil-set-initial-state m 'emacs)))))
  :general
  (+mmap-at-def
    "m"   '(nil :which-key "mail")
    "m m" 'wl))

(package! mime-w3m)
  :straight nil
  :after w3m)
