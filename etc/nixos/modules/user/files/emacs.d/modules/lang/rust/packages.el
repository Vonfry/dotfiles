;;; rust config -*- lexical-binding: t -*-
;;

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . eglot)
  :general
  (nmap-mode :keymaps 'rust-mode-map
    "=" 'rust-mode-indent-line
    "t" 'rust-test
    "R" 'rust-run)
  (nmap-leader :keymaps 'rust-mode-map
    "r" 'rust-compile
    "R" '+rust/lldb))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode)
  :general
  (nmap-mode :keymaps 'rust-mode-map
    "c e" 'cargo-process-bench
    "c b" 'cargo-process-build
    "c l" 'cargo-process-clean
    "c d" 'cargo-process-doc
    "c v" 'cargo-process-doc-open
    "c n" 'cargo-process-new
    "c i" 'cargo-process-init
    "c r" 'cargo-process-run
    "c x" 'cargo-process-run-example
    "c s" 'cargo-process-search
    "c t" 'cargo-process-test
    "c u" 'cargo-process-update
    "c c" 'cargo-process-repeat
    "c f" 'cargo-process-current-test
    "c o" 'cargo-process-current-file-tests
    "c m" 'cargo-process-fmt
    "c k" 'cargo-process-check
    "c K" 'cargo-process-clippy
    "c a" 'cargo-process-add
    "c D" 'cargo-process-rm
    "c U" 'cargo-process-upgrade))
