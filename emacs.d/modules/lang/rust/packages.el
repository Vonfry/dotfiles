;;; rust config -*- lexical-binding: t -*-
;;

(package! rust-mode
  :mode "\\.rs\\"

  :general
  (nmap :keymaps 'rust-mode
        :prefix +nmap-lang-prefix
        +nmap-align 'rust-mode-indent-line
        "t" 'rust-test
        "c" 'rust-compile
        "R" 'rust-run)
  (nmap :keymaps 'haskell-mode-map
        :prefix +nmap-leader
        +nmap-run 'rust-compile))

(package! cargo
  :hook (rust-mode . cargo-minor-mode)
  :general
  (nmap :keymaps 'rust-mode-map
        :prefix +nmap-rust-compile-prefix
        "e" 'cargo-process-bench
        "b" 'cargo-process-build
        "l" 'cargo-process-clean
        "d" 'cargo-process-doc
        "v" 'cargo-process-doc-open
        "n" 'cargo-process-new
        "i" 'cargo-process-init
        "r" 'cargo-process-run
        "x" 'cargo-process-run-example
        "s" 'cargo-process-search
        "t" 'cargo-process-test
        "u" 'cargo-process-update
        "c" 'cargo-process-repeat
        "f" 'cargo-process-current-test
        "o" 'cargo-process-current-file-tests
        "m" 'cargo-process-fmt
        "k" 'cargo-process-check
        "K" 'cargo-process-clippy
        "a" 'cargo-process-add
        "D" 'cargo-process-rm
        "U" 'cargo-process-upgrade))
