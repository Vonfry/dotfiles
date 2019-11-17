;;; rust config -*- lexical-binding: t -*-
;;

(package! rust-mode
  :mode "\\.rs\\'"
  :general
  (+nmap-lang-rust-def
    "=" 'rust-mode-indent-line
    "t" 'rust-test
    "c" 'rust-compile
    "R" 'rust-run)
  (+nmap-rust-def
    "r" 'rust-compile))

(package! cargo
  :hook (rust-mode . cargo-minor-mode)
  :general
  (+nmap-lang-rust-def
    "r e" 'cargo-process-bench
    "r b" 'cargo-process-build
    "r l" 'cargo-process-clean
    "r d" 'cargo-process-doc
    "r v" 'cargo-process-doc-open
    "r n" 'cargo-process-new
    "r i" 'cargo-process-init
    "r r" 'cargo-process-run
    "r x" 'cargo-process-run-example
    "r s" 'cargo-process-search
    "r t" 'cargo-process-test
    "r u" 'cargo-process-update
    "r c" 'cargo-process-repeat
    "r f" 'cargo-process-current-test
    "r o" 'cargo-process-current-file-tests
    "r m" 'cargo-process-fmt
    "r k" 'cargo-process-check
    "r K" 'cargo-process-clippy
    "r a" 'cargo-process-add
    "r D" 'cargo-process-rm
    "r U" 'cargo-process-upgrade))
