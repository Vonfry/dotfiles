;;; cc config -*- lexical-binding: t -*-

(use-package! rtags
  :after helm company
  :config
  (setq rtags-display-result-backend 'helm)
  :hook (irony-mode .
    (lambda ()
      ;; this is installed by the cflow package on os
      (use-package! cflow-mode)
      (use-package! call-graph
        :general
        (nmap :keymaps 'local
              :prefix +lang-nmap-prefix
              "g" 'call-graph))
      (rtags-start-process-unless-running)
      (rtags-enable-standard-keybindings)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "'"  'rtags-print-symbol-info
            "c"  'rtags-print-dependencies
            ","  'rtags-find-references
            "?"  'rtags-find-references-at-point
            "/"  'rtags-find-symbol
            "."  'rtags-find-symbol-at-point
            "d"  'rtags-diagnostics
            "t"  'rtags-references-tree
            "m"  'rtags-imenu
            "ll" 'rtags-find-file
            "li" 'rtags-include-file
            "w"  'rtags-rename-symbol
            "u"  'rtags-find-virtuals-at-point
            "b"  'rtags-location-stack-back
            "f"  'rtags-location-stack-forward)
      (if (rtags-is-indexed)
        (nmap :keymaps 'local
              :prefix vonfry-keybind-evil-leader
              "'" 'rtags-print-symbol-info
              vonfry-keybind-evil-jump-to-definition 'rtags-find-symbol-at-point
              vonfry-keybind-evil-jump-to-others     'rtags-find-references
              vonfry-keybind-evil-jump-module        'rtags-include-file
              vonfry-keybind-evil-jump-back          'rtags-location-stack-back
              vonfry-keybind-evil-code               'rtags-imenu)))))

;; this is used in all program lang
(use-package! semantic
	:custom
  (semantic-default-submodes
    '(global-semantic-highlight-func-mode
      global-semantic-idle-local-symbol-highlight-mode
      global-semantic-stickyfunc-mode
      global-semantic-highlight-edits-mode
      global-semantic-show-parser-state-mode))
  :config
	(semantic-mode t))

(use-package! disaster
	:hook (irony-mode .
	  (lambda ()
		  (nmap :keymaps 'local
				:prefix +lang-nmap-prefix
				"d" 'disaster))))

;; this is used in all program lang
(use-package! compile)

(use-package! irony
  :after yasnippet
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
  :hook
  ((c++-mode . irony-mode)
  (c-mode . irony-mode)
  (objc-mode . irony-mode)
  (irony-mode . irony-cdb-autosetup-compile-options)
	(irony-mode .
		(lambda()
			(use-package! cc-mode)
			(custom-set-variables
				'(c-default-style "k&r")
				'(c-basic-offset 4))
			(setq
				gdb-many-windows t
				gdb-show-main t)
			(nmap :keymaps 'local
	 			  :prefix +lang-nmap-prefix
				  "h" 'ff-find-other-file)))))

;; Use irony-hook to instead all c/c++ hook because irony-mode is always used in these mode.

(use-package! company-irony
  :after company irony
  :hook
  (irony-mode .
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-irony))))

(use-package! flycheck-irony
  :after flycheck irony
  :hook
  (flycheck-mode . flycheck-irony-setup))

(use-package! irony-eldoc
  :hook
  (irony-mode . irony-eldoc))

(use-package! function-args
  :custom
  (moo-select-method 'helm)
  :hook
  ((irony-mode . fa-config-default)
  (irony-mode .
    (lambda()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "."     'fa-jump
            "s"     'fa-show
            "v"     'moo-propose-virtual
            "o"     'moo-propose-override
			"j"     'moo-jump-local)))))

(use-package! cmake-mode
  :config
	(setq auto-mode-alist
		(append
			'(("CMakeLists\\.txt\\'" . cmake-mode))
			'(("\\.cmake\\'" . cmake-mode))
			auto-mode-alist))
  (autoload 'cmake-mode "~/CMake/Auxiliary/cmake-mode.el" t))

(use-package! cmake-font-lock
  :after cmake-mode
  :hook
  (cmake-mode . cmake-font-lock-activate))

(use-package! helm-rtags
  :after rtags helm)

(use-package! call-graph)
