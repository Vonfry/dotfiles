;;; cc config -*- lexical-binding: t -*-

(vonfry|use-package! rtags
  :after helm company
  :init
  :config
  (setq rtags-display-result-backend 'helm)
  (add-hook 'irony-mode-hook
            (lambda ()
              (rtags-start-process-unless-running)
              (rtags-enable-standard-keybindings)
              (nmap :keymaps 'local
                    :prefix +lang-nmap-prefix
                    "'"  'rtags-print-symbol-info
                    "c"  'rtags-print-dependencies
                    "."  'rtags-find-references
                    "?"  'rtags-find-references-at-point
                    "/"  'rtags-find-symbol
                    ","  'rtags-find-symbol-at-point
                    "r"  'rtags-diagnostics
                    "t"  'rtags-restart-process
                    "m"  'rtags-imenu
                    "ll" 'rtags-find-file
                    "li" 'rtags-include-file
                    "w"  'rtags-rename-symbol
                    "u"  'rtags-find-virtuals-at-point
                    "b"  'rtags-location-stack-back
                    "f"  'rtags-location-stack-forward)
              (nmap :keymaps 'local
                    :prefix vonfry-keybind-evil-leader
                    "'" 'rtags-print-symbol-info
                    vonfry-keybind-evil-jump-to-definition 'rtags-find-references-at-point
                    vonfry-keybind-evil-jump-module        'rtags-include-file
                    vonfry-keybind-evil-jump-back          'rtags-location-stack-back
                    vonfry-keybind-evil-code 'rtags-imenu))))

;; this is used in all program lang
(vonfry|use-package! semantic
  :config
	(custom-set-variables
		'(semantic-default-submodes
				'(global-semantic-highlight-func-mode
					global-semantic-idle-local-symbol-highlight-mode
					global-semantic-stickyfunc-mode
					global-semantic-highlight-edits-mode
					global-semantic-show-parser-state-mode)))
	(semantic-mode t))

(vonfry|use-package! disaster
	:config
	(add-hook 'irony-mode-hook
	  (lambda ()
		  (nmap :keymaps 'local
						:prefix +lang-nmap-prefix
						"d" 'disaster))))

;; this is used in all program lang
(vonfry|use-package! compile)

(vonfry|use-package! irony
  :init
  (defcustom +irony-dir
    (expand-file-name "irony/" vonfry-local-dir)
    "irony local dir"
    :type 'directory
    :group 'vonfry-modules)
  (custom-set-variables
    '(irony-user-dir +irony-dir)
    '(irony-server-install-prefix +irony-dir))
  :config
  ;; (irony-install-server) should be run at first.
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
	(add-hook 'irony-mode-hook
		(lambda()
			(vonfry|use-package! cc-mode)
			(custom-set-variables
				'(c-default-style "k&r")
				'(c-basic-offset 4))
			(setq
				gdb-many-windows t
				gdb-show-main t)
			(nmap :keymaps 'local
						:prefix +lang-nmap-prefix
						"h" 'ff-find-other-file))))

;; Use irony-hook to instead all c/c++ hook because irony-mode is always used in these mode.

(vonfry|use-package! company-irony
  :after company irony
  :config
  (add-hook 'irony-mode-hook
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-irony))))

(vonfry|use-package! flycheck-irony
  :after flycheck irony
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(vonfry|use-package! irony-eldoc
  :config
  (add-hook 'irony-mode-hook 'irony-eldoc))

(vonfry|use-package! function-args
  :config
  (add-hook 'irony-mode-hook 'fa-config-default)
  (add-hook 'irony-mode-hook
    (lambda()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "."     'fa-jump
            "s"     'fa-show
            "v"     'moo-propose-virtual
            "o"     'moo-propose-override
						"j"     'moo-jump-local))))

(vonfry|use-package! cmake-mode
  :config
	(setq auto-mode-alist
		(append
			'(("CMakeLists\\.txt\\'" . cmake-mode))
			'(("\\.cmake\\'" . cmake-mode))
			auto-mode-alist))
  (autoload 'cmake-mode "~/CMake/Auxiliary/cmake-mode.el" t))

(vonfry|use-package! cmake-font-lock
  :after cmake-mode
  :config
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate))
