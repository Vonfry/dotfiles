;;; cc packages -*- lexical-binding: t -*-
;;

(package! cquery
  :after lsp-mode
  :hook ((c-mode c++-mode objc-mode) . lsp-cquery-enable)
  :custom
  (cquery-executable "cquery")
  (cquery-sem-highlight-method 'font-lock))

(package! disaster
  :general
  (nmap :keymaps '(c-mode-map c++-mode-map objc-mode-map)
        :prefix +nmap-lang-prefix
        "d" 'disaster))

;; this is used in all program lang
(package! compile
  :ensure nil
  :general
  (nmap :prefix +nmap-leader
        +nmap-run 'compile))

(package! function-args
  :custom (moo-select-method 'ivy)
  :hook ((c-mode c++-mode objc-mode) . 'fa-config-default)
  :general
  (nmap :keymaps '(c-mode-map c++-mode-map objc-mode-map)
        :prefix +nmap-lang-prefix
        +nmap-go        'fa-jump
        +nmap-go-peek   'fa-show
        +nmap-virtual   'moo-propose-virtual
        +nmap-swiper    'moo-jump-local
        "o" 'moo-propose-override))

(package! cmake-mode
  :mode ("\\.cmake\\'" "CMakeLists\\.txt\\'")
  :config
  (autoload 'cmake-mode "~/CMake/Auxiliary/cmake-mode.el" t))

(package! cmake-font-lock
  :after cmake-mode
  :hook
  (cmake-mode . cmake-font-lock-activate))
