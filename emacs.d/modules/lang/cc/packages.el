;;; cc packages -*- lexical-binding: t -*-
;;
;; Use rtags to jump and use irony to do completion and error check. And use EBrowse to make a class graph.

(package! call-graph)

(package! rtags
  :after ivy company
  :config
  (setq rtags-display-result-backend 'ivy)
  :hook (irony-mode .
    (lambda ()
      ;; this is installed by the cflow package on os
      (package! cflow-mode :ensure nil)
      (package! call-graph
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
              vonfry-keybind-evil-code-help   'rtags-print-symbol-info
              vonfry-keybind-evil-jump-module 'rtags-include-file
              vonfry-keybind-evil-code        'rtags-imenu)))))

;; this is used in all program lang
(package! semantic
  :ensure nil
	:custom
  (semantic-default-submodes
    '(global-semantic-highlight-func-mode
      global-semantic-idle-local-symbol-highlight-mode
      global-semantic-stickyfunc-mode
      global-semantic-highlight-edits-mode
      global-semantic-show-parser-state-mode))
  :config
	(semantic-mode t))

(package! disaster
	:hook (irony-mode .
	  (lambda ()
		  (nmap :keymaps 'local
				:prefix +lang-nmap-prefix
				"d" 'disaster))))

;; this is used in all program lang
(package! compile
  :ensure nil
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-run 'compile))

(package! irony
  :after yasnippet
  :init
  (irony-user-dir +irony-dir)
  (irony-server-install-prefix +irony-dir)
  (irony-extra-cmake-args +irony-extra-cmake-args)
  :custom
  (gdb-many-windows t)
  (gdb-show-main t)
  :hook
  ((c++-mode . irony-mode)
  (c-mode . irony-mode)
  (objc-mode . irony-mode)
  (irony-mode . irony-cdb-autosetup-compile-options)
	(irony-mode .
		(lambda()
			(package! cc-mode :ensure nil)
			(nmap :keymaps 'local
	 			  :prefix +lang-nmap-prefix
				  "h" 'ff-find-other-file)))))

;; Use irony-hook to instead all c/c++ hook because irony-mode is always used in these mode.

(package! company-irony
  :after company irony
  :hook
  (irony-mode .
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-irony))))

(package! flycheck-irony
  :after flycheck irony
  :hook
  (flycheck-mode . flycheck-irony-setup))

(package! function-args
  :custom
  (moo-select-method 'ivy)
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

(package! cmake-mode
  :custom
  (compile-command "cmake")
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

(package! cmake-font-lock
  :after cmake-mode
  :hook
  (cmake-mode . cmake-font-lock-activate))

(package! ivy-rtags
  :after rtags ivy)
