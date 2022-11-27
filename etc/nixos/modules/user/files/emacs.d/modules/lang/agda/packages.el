;;; agda pagkages -*- lexical-binding: t -*-
;;

(use-package agda2-mode
  :after agda2
  :general
  (nmap-leader :keymaps 'agda2-mode-map
    "."   'agda2-goto-definition-keyboard
    ","   'agda2-go-back
    ";"   'agda2-module-contents-maybe-toplevel
    "&"   'agda2-search-about-toplevel
    "r"   'agda2-compile
    ")"   'eri-indent
    "("   'eri-indent-reverse
    "c x" 'agda2-comment-dwim-rest-of-buffer
    "' b" 'agda2-load
    "r"   'agda2-compile

    "RET"   'agda2-give
    "' RET" 'agda2-elaborate-give)
  (nmap-mode :keymaps 'agda2-mode-map
    "q"   'agda2-quit
    "R"   'agda2-restart
    "A"   'agda2-abort
    "d"   'agda2-remove-annotations
    "h"   'agda2-display-implicit-arguments
    "i"   'agda2-display-irrelevant-arguments
    "S"   'agda2-set-program-version
    "a"   'agda2-auto-maybe-all
    "d"   'agda2-infer-type-maybe-toplevel
    ","   'agda2-goal-and-context
    "."   'agda2-goal-and-context-and-inferred
    ";"   'agda2-goal-and-context-and-checked
    "e"   'agda2-show-context
    "s"   'agda2-solve-maybe-all
    "?"   'agda2-show-goals
    "n"   'agda2-next-goal
    "p"   'agda2-previous-goal
    "t"   'agda2-goal-type
    "r"   'agda2-refine
    "c"   'agda2-make-case
    "N"   'agda2-compute-normalised-maybe-toplevel
    ")"   'agda2-show-constraints
    "w"   'agda2-why-in-scope-maybe-toplevel
    "v"   'agda2-display-program-version
    "V"   'agda2-set-program-version
    "?"   'agda2-helper-function-type
    ))
