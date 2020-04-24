;;; core-editor.el -*- lexical-binding: t; -*-
;;
;; Set the configure about editing.

(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))

(defgroup vonfry-editor nil
  "Vonfry's group about editor")

(defcustom vonfry-frame '((width . 160) (height . 72))
  "The default frame width and height, see `initial-frame-alist'"
  :type 'sexp
  :group 'vonfry-editor)

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

(custom-set!
  exec-path-from-shell-check-startup-files nil
  initial-frame-alist vonfry-frame
  default-frame-alist vonfry-frame
  blink-cursor-interval 0.4
  buffers-menu-max-size 32
  column-number-mode t
  display-line-numbers t
  global-whitespace-mode nil
  case-fold-search t
  line-spacing 0

  bookmark-default-file (expand-file-name "bookmarks.el" vonfry-local-dir)

  recentf-mode 1
  recentf-max-menu-items 10
  recentf-max-saved-items 1000

  mouse-yank-at-point t
  delete-selection-mode t

  tab-always-indent 'always
  indent-tabs-mode nil
  tab-width 4
  c-default-style "k&r"
  c-basic-offset 4

  scroll-bar-mode nil
  scroll-preserve-screen-position 'always
  set-mark-command-repeat-pop t
  tooltip-delay 0.7

  word-wrap nil
  truncate-lines nil
  truncate-partial-width-windows vonfry-text-width
  fill-column vonfry-text-width
  show-trailing-whitespace nil

  save-interprogram-paste-before-kill t

  make-backup-files t
  backup-directory-alist `((".*" . ,vonfry-backup-file-dir))
  auto-save-default nil
  auto-save-file-name-transforms `((".*" ,vonfry-auto-save-dir t))
  auto-save-list-file-prefix vonfry-auto-save-list-prefix

  global-visual-line-mode t
  show-paren-mode t

  tramp-default-method "ssh"
  tramp-auto-save-directory vonfry-tramp-cache
  tramp-backup-directory-alist `((".*" ,vonfry-tramp-cache))

  recentf-save-file (expand-file-name "recentf" vonfry-cache-dir)

  custom-file vonfry-custom-file
  abbrev-file-name (expand-file-name "abbrev_defs" vonfry-cache-dir)
  save-abbrevs 'silently

  semanticdb-default-save-directory (expand-file-name "semanticdb" vonfry-cache-dir)
  nsm-settings-file (expand-file-name "nsm.data" vonfry-cache-dir))

(hook! text-mode turn-on-auto-fill)
(hook! prog-mode turn-on-auto-fill)

(package! exec-path-from-shell
  :when (and (memq window-system '(mac ns x))
             (not (string-match "fish" (getenv "SHELL")))
             (not (getenv "VONFRY_SHELL")))
  :config
  (exec-path-from-shell-initialize))

(fun! vonfry/toggle-trailing-whitespace ()
  (interactive)
  (setq show-trailing-whitespace (not show-trailing-whitespace)))

(hook! text-mode vonfry/toggle-trailing-whitespace)
(hook! prog-mode vonfry/toggle-trailing-whitespace)

(package! whitespace-cleanup-mode
  :custom
  (whitespace-style '(face
                      tabs
                      spaces
                      trailing
                      lines
                      space-before-tab
                      newline
                      indentation
                      empty
                      space-after-tab
                      space-mark
                      tab-mark
                      newline-mark
                      lines-tail))
  :hook
  ((prog-mode . whitespace-cleanup-mode)
   (text-mode . whitespace-cleanup-mode)))

(package! hl-line
  :hook
  (after-init . global-hl-line-mode))

(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

(fun! vonfry/local-indent (int)
  (interactive "Ntab-indent: ")
  (set (make-local-variable 'tab-indent) int))

(provide 'vonfry-editor)
