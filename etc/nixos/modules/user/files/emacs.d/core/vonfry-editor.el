;;; core-editor.el -*- lexical-binding: t; -*-
;;
;; Set the configure about editing.

(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))

(defgroup vonfry-editor nil
  "Vonfry's group about editor")

(defcustom vonfry-text-width 80
  "The width for a line"
  :type 'number
  :group 'vonfry-editor)

(defcustom vonfry-backup-file-dir (expand-file-name "backups/" vonfry-cache-dir)
  "The backup file dir."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-auto-save-dir (expand-file-name "auto-save/" vonfry-cache-dir)
  "The auto-save file dir."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-auto-save-list-prefix vonfry-auto-save-dir
  "The auto-save file prefix."
  :type 'string
  :group 'vonfry-dir)

(dolist (tmp-dir `(,vonfry-backup-file-dir ,vonfry-auto-save-dir))
  (unless (file-exists-p tmp-dir)
    (make-directory tmp-dir)))

(setq-default
  whitespace-style '(face trailing lines-tail)
  case-fold-search t
  line-spacing 0
  display-line-numbers 'relative

  blink-cursor-interval 0.4
  buffers-menu-max-size 32

  bookmark-default-file (expand-file-name "bookmarks.el" vonfry-local-dir)

  recentf-max-menu-items 10
  recentf-max-saved-items 1000
  mouse-yank-at-point t
  delete-selection-mode t

  tab-always-indent 'always
  tab-width 4
  c-default-style "k&r"
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
  tramp-backup-directory-alist nil

  recentf-save-file (expand-file-name "recentf" vonfry-cache-dir)

  abbrev-file-name (expand-file-name "abbrev_defs" vonfry-cache-dir)
  dabbrev-case-fold-search t
  save-abbrevs 'silently

  semanticdb-default-save-directory (expand-file-name "semanticdb"
                                                      vonfry-cache-dir)
  nsm-settings-file (expand-file-name "nsm.data" vonfry-cache-dir)

  epg-pinentry-mode 'loopback

  indent-tabs-mode nil)

(defvaralias 'c-basic-offset 'tab-width)

(recentf-mode 1)
(show-paren-mode 1)
(visual-line-mode 1)

(dolist (mode '(prog-mode-hook text-mode-hook))
  (add-hook mode 'turn-on-auto-fill)
  (add-hook mode 'whitespace-mode))

(unless (daemonp)
  (add-hook 'after-init-hook 'server-start))

(use-package whitespace-cleanup-mode
  :hook
  ((text-mode prog-mode) . whitespace-cleanup-mode))

(use-package hl-line
  :hook
  (after-init . global-hl-line-mode))

(use-package saveplace
  :ensure nil
  :custom
  (save-place-file (expand-file-name "saveplace" vonfry-cache-dir))
  :hook (after-init . save-place-mode))

(defun vonfry/local-indent (int)
  (interactive "Ntab-indent: ")
  (setq-local tab-width int))

(provide 'vonfry-editor)
