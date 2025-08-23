;;; latex/packages.el --- -*- lexical-binding: t -*-
;;

(use-package latex
  :ensure auctex
  :config
  ; this is for pdf tools
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer)
  :custom
  (TeX-master nil)
  (TeX-PDF-mode t)
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-syntactic-comment t)
  (LaTeX-fill-break-at-separators nil)
  (reftex-plug-into-AUCTeX '(nil nil t t t))
  (TeX-auto-untabify t)
  (TeX-engine 'luatex)
  (TeX-save-query nil)
  (TeX-auto-global (expand-file-name "latex" vonfry-cache-dir))
  (TeX-output-dir "latex.out")
  (TeX-auto-local "latex.out")
  (TeX-style-local TeX-auto-local)
  (TeX-auto-private (expand-file-name "tex/" vonfry-cache-dir))
  (TeX-region (concat TeX-auto-local "/_region_"))
  (TeX-view-program-selection '((output-pdf "PDF Tools")
                                (output-dvi "xdvi")
                                (output-html "xdg-open")))
  ;; Synctex support
  ;; Don't insert line-break at inline math
  (TeX-show-compilation nil)
  (TeX-source-correlate-mode t)
  :hook
  ((LaTeX-mode . reftex-mode)
   (LaTex-mode . rainbow-delimiters-mode)
   (LaTex-mode . eglot-ensure)
   (LaTex-mode . LaTeX-math-mode))
  :general
  (:keymaps 'TeX-mode-map
    (kbd "TAB") 'TeX-complete-symbol)
  (nmap-leader :keymaps '(TeX-mode-map)
    "?"      'TeX-doc
    "RET"    'preview-at-point
    "' c"    'TeX-command-master)
  (nmap-mode :keymaps '(TeX-mode-map)
    "-"       'TeX-recenter-output-buffer
    "R"       'TeX-command-run-all
    "%"       'TeX-comment-or-uncomment-paragraph
    "k"       'TeX-kill-job
    "l"       'TeX-recenter-output-buffer
    "m"       'TeX-insert-macro
    "v"       'TeX-view
    "C"       'TeX-clean
    "n"       'TeX-narrow-to-group
    "*"       'LaTeX-mark-section
    "."       'LaTeX-mark-environment
    "c"       'LaTeX-close-environment
    "e"       'LaTeX-environment
    "i"       'LaTeX-insert-item
    "s"       'LaTeX-section
    "f"       'TeX-font
    "F e"     'LaTeX-fill-environment
    "F p"     'LaTeX-fill-paragraph
    "F s"     'LaTeX-fill-section
    "p b"     'preview-buffer
    "p c"     'preview-clearout
    "p d"     'preview-document
    "p e"     'preview-environment
    "p f"     'preview-cache-preamble
    "p s"     'preview-section
    "z ="     'TeX-fold-math
    "z b"     'TeX-fold-buffer
    "z e"     'TeX-fold-env
    "z m"     'TeX-fold-macro
    "r c"     'reftex-citation
    "r g"     'reftex-grep-document
    "r i"     'reftex-index-selection-or-word
    "r I"     'reftex-display-index
    "r TAB"   'reftex-index
    "r l"     'reftex-label
    "r p"     'reftex-index-phrase-selection-or-word
    "r P"     'reftex-index-visit-phrases-buffer
    "r r"     'reftex-reference
    "r s"     'reftex-search-document
    "r t"     'reftex-toc
    "r T"     'reftex-toc-recenter
    "r v"     'reftex-view-crossref)
  (vmap-mode :keymaps '(TeX-mode-map)
    "F r"     'LaTeX-fill-region
    "p r"     'preview-region
    "z r"     'TeX-fold-region
    ";"       'TeX-comment-or-uncomment-region))
