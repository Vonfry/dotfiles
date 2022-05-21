;;; agda pagkages -*- lexical-binding: t -*-
;;

(use-package agda2-mode
  :init
  ; because agda2-mode included in agda package needs agda in path when loading
  (+agda--mode-load)
  :general
  (nmap-leader :keymaps 'agda2-mode-map
    "("   'agda2-infer-type-maybe-toplevel
    "&"   'agda2-search-about-toplevel
    ";"   'agda2-module-contents-maybe-toplevel
    ","   'agda2-go-back
    "."   'agda2-goto-definition-keyboard
    "r"   'agda2-compile
    "{"   'agda2-auto-maybe-all
    "} ." 'agda2-goal-and-context-and-inferred
    "} ;" 'agda2-goal-and-context-and-checked
    "} t" 'agda2-show-context
    "} r" 'agda2-solve-maybe-all
    "} {" 'agda2-show-goals
    "} n" 'agda2-next-goal
    "} p" 'agda2-previous-goal
    "} t" 'agda2-goal-type
    "} r" 'agda2-refine
    "} c" 'agda2-make-case
    "?"   'agda2-helper-function-type
    "t"   'agda2-goal-and-context
    "["   'agda2-why-in-scope-maybe-toplevel
    "("   'agda2-compute-normalised-maybe-toplevel
    ")"   'agda2-show-constraints
    "c x" 'agda2-comment-dwim-rest-of-buffer
    "' b" 'agda2-load

    "RET"   'agda2-give
    "' RET" 'agda2-elaborate-give)
  (nmap-mode :keymaps 'agda2-mode-map
    "q" 'agda2-quit
    "R" 'agda2-restart
    "A" 'agda2-abort
    "d" 'agda2-remove-annotations
    "h" 'agda2-display-implicit-arguments
    "i" 'agda2-display-irrelevant-arguments
    "S" 'agda2-set-program-version
    ")" 'eri-indent
    "(" 'eri-indent-reverse))
