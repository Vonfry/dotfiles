;;; core/vonfry-editor.el --- -*- lexical-binding: t; -*-
;;
;; Set the configure about editing.

(defgroup vonfry-editor nil
  "Vonfry's group about editor."
  :group 'vonfry)

(defcustom vonfry-text-width 80
  "The width for a line."
  :type 'number
  :group 'vonfry-editor)

(defcustom vonfry-backup-file-dir (expand-file-name "backups/" vonfry-cache-dir)
  "The backup file dir."
  :type 'directory
  :group 'vonfry-editor)

(defcustom vonfry-auto-save-dir (expand-file-name "auto-save/" vonfry-cache-dir)
  "The auto-save file dir."
  :type 'directory
  :group 'vonfry-editor)

(defcustom vonfry-auto-save-list-prefix vonfry-auto-save-dir
  "The auto-save file prefix."
  :type 'string
  :group 'vonfry-editor)

(dolist (tmp-dir `(,vonfry-backup-file-dir ,vonfry-auto-save-dir))
  (unless (file-exists-p tmp-dir)
    (make-directory tmp-dir)))

(setopt
  whitespace-style '(face trailing lines-tail)
  case-fold-search t
  line-spacing 0
  display-line-numbers nil

  blink-cursor-interval 0.4
  buffers-menu-max-size 32

  bookmark-default-file (expand-file-name "bookmarks.el" vonfry-local-dir)

  recentf-max-menu-items 10
  recentf-max-saved-items 1000
  mouse-yank-at-point t
  delete-selection-mode t

  tab-always-indent 'always
  scroll-preserve-screen-position 'always
  set-mark-command-repeat-pop t
  tooltip-delay 0.7

  truncate-lines nil
  truncate-partial-width-windows vonfry-text-width
  fill-column vonfry-text-width
  save-interprogram-paste-before-kill t

  make-backup-files t
  backup-directory-alist `(("." . ,vonfry-backup-file-dir))
  auto-save-default t
  auto-save-file-name-transforms `((".*" ,vonfry-auto-save-dir t))
  auto-save-list-file-prefix vonfry-auto-save-list-prefix

  tramp-default-method "sshx"
  tramp-save-ad-hoc-proxies t
  tramp-auto-save-directory vonfry-auto-save-dir
  tramp-persistency-file-name (expand-file-name "tramp" vonfry-cache-dir)
  tramp-backup-directory-alist backup-directory-alist

  recentf-save-file (expand-file-name "recentf" vonfry-cache-dir)

  abbrev-file-name (expand-file-name "abbrev_defs" vonfry-cache-dir)
  dabbrev-case-fold-search t
  save-abbrevs 'silently

  semanticdb-default-save-directory (expand-file-name "semanticdb"
                                                      vonfry-cache-dir)
  nsm-settings-file (expand-file-name "nsm.data" vonfry-cache-dir)

  epg-pinentry-mode 'loopback

  indent-tabs-mode nil

  gc-cons-threshold (* 100 1024 1024) ; 1 mib
  read-process-output-max (* 1024 1024) ; 1mb

  calc-settings-file (expand-file-name "calc.el" vonfry-local-dir)

  delete-by-moving-to-trash t)

(recentf-mode 1)
(show-paren-mode 1)
(global-visual-line-mode 1)
(column-number-mode 1)
(line-number-mode 1)

(dolist (mode '(prog-mode-hook text-mode-hook))
  (add-hook mode 'turn-on-auto-fill)
  (add-hook mode 'whitespace-mode))

(use-package whitespace-cleanup-mode
  :hook
  ((text-mode prog-mode) . whitespace-cleanup-mode))

(use-package hl-line
  :config
  (global-hl-line-mode))

(use-package saveplace
  :ensure nil
  :custom
  (save-place-file (expand-file-name "saveplace" vonfry-cache-dir))
  :config
  (save-place-mode 1))

(defun vonfry/local-indent (int)
  "Change indent buffer locally."
  (interactive "Ntab-indent: ")
  (setq-local tab-width int))

(provide 'vonfry-editor)
