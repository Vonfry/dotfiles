;;; cc packages -*- lexical-binding: t -*-
;;

(package! cquery
  :after lsp-mode
  :hook ((c-mode c++-mode objc-mode) . lsp-cquery-enable)
  :custom
  (cquery-executable "cquery")
  (cquery-sem-highlight-method 'font-lock))

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
  :general
  (nmap :keymaps '(c-mode c++-mode objc-mode)
        :definer 'minor-mode
        :prefix +lang-nmap-prefix
        "d" 'disaster))

;; this is used in all program lang
(package! compile
  :ensure nil
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-run 'compile))

(package! function-args
  :custom (moo-select-method 'helm)
  :hook ((c-mode c++-mode objc-mode) . 'fa-config-default)
  :general
  (nmap :keymaps '(c-mode c++-mode objc-mode)
        :definer 'minor-mode
        :prefix +lang-nmap-prefix
        "."     'fa-jump
        "s"     'fa-show
        "v"     'moo-propose-virtual
        "o"     'moo-propose-override
        "j"     'moo-jump-local))

(package! cmake-mode
  :mode ("\\.cmake\\'" "CMakeLists\\.txt\\'")
  :config
  (autoload 'cmake-mode "~/CMake/Auxiliary/cmake-mode.el" t))

(package! cmake-font-lock
  :after cmake-mode
  :hook
  (cmake-mode . cmake-font-lock-activate))
