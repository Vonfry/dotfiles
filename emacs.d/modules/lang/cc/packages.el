;;; cc packages -*- lexical-binding: t -*-
;;

(package! disaster
  :general
  (+mmap-mode-cc-def
    "d" 'disaster))

;; this is used in all program lang
(package! compile
  :straight nil
  :general
  (+mmap-leader-def
    "r" 'compile))

(package! function-args
  :custom (moo-select-method 'ivy)
  :hook ((c-mode c++-mode objc-mode) . 'fa-config-default)
  :general
  (+mmap-mode-cc-def
    "." 'fa-jump
    "&" 'fa-show
    "v" 'moo-propose-virtual
    "/" 'moo-jump-local
    "o" 'moo-propose-override))

(package! cmake-mode
  :mode ("\\.cmake\\'" "CMakeLists\\.txt\\'")
  :config
  (autoload 'cmake-mode "~/CMake/Auxiliary/cmake-mode.el" t))

(package! cmake-font-lock
  :after cmake-mode
  :hook
  (cmake-mode . cmake-font-lock-activate))

(package! realgud-lldb
  :after realgud
  :general
  (+mmap-cc-def
    "R" '+cc/lldb))
