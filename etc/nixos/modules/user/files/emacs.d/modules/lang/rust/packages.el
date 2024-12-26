;;; rust/config.el --- -*- lexical-binding: t -*-
;;

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook ((rust-mode rust-ts-mode) . eglot-ensure)
  :general
  (nmap-mode :keymaps '(rust-mode-map rust-ts-mode-map)
    "=" 'rust-format-buffer
    "t" 'rust-test
    "k" 'rust-check
    "k" 'rust-run-clippy
    "R" 'rust-run-release
    "r" 'rust-run
    "d" 'rust-dbg-wrap-or-unwrap)
  (nmap-leader :keymaps '(rust-mode-map rust-ts-mode-map)
    "' c" 'rust-compile
    "' r" 'rust-run
    "' R" 'rust-run-release))

(use-package cargo
  :hook ((rust-mode rust-ts-mode) . cargo-minor-mode)
  :custom
  (cargo-process--custom-path-to-bin "cargo")
  (cargo-process--rustc-cmd "rustc")
  :general
  (nmap-mode :keymaps 'cargo-mode-map
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
