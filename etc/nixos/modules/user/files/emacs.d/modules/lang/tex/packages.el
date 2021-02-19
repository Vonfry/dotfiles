;;; latex packages -*- lexical-binding: t -*-
;;

(use-package latex
  :ensure auctex
  :after company
  :custom
  (TeX-master nil)
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-syntactic-comment t)
  (LaTeX-fill-break-at-separators nil)
  (reftex-plug-into-AUCTeX '(nil nil t t t))
  (TeX-command-default "latexmk")
  (TeX-command "latexmk")
  (TeX-auto-untabify t)
  (TeX-engine 'xetex)
  (TeX-save-query nil)
  (TeX-auto-global (expand-file-name "latex" vonfry-cache-dir))
  (TeX-auto-local "latex.out")
  (TeX-style-local TeX-auto-local)
  (TeX-auto-private (expand-file-name "tex/" vonfry-cache-dir))
  (TeX-region (expand-file-name "_region_" TeX-auto-local))
  (TeX-view-program-selection '((output-pdf "zathura")
                                (output-dvi "xdvi")
                                (output-html "xdg-open")))
  ;; Synctex support
  ;; Don't insert line-break at inline math
  (TeX-show-compilation t) ; display compilation windows
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-method 'synctex)
  (reftex-citation-format 'biblatex)
  :hook
  (LaTeX-mode .
     (lambda ()
       (set (make-local-variable 'compile-command)
            (s-trim (s-join " "
                            (list
                             "latexmk"
                             (file-relative-name buffer-file-name)))))
       (require 'preview)
       (require 'tex-site)
       ;; use pdfview with auctex
       ;; have the buffer refresh after compilation
       (reftex-mode)
       (rainbow-delimiters-mode)
       (LaTeX-math-mode)
       (lsp)))
  :general
  (:keymaps 'TeX-mode-map
    (kbd "TAB") 'TeX-complete-symbol)
  (nmap-leader :keymaps '(TeX-mode-map)
    "?"      'TeX-doc
    "RET"    'preview-at-point
    "r"      'compile
    "R"      'TeX-command-run-all)
  (nmap-mode :keymaps '(TeX-mode-map)
    "-"       'TeX-recenter-output-buffer
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
    "f"       '(nil :which-key "fill")
    "f e"     'LaTeX-fill-environment
    "f p"     'LaTeX-fill-paragraph
    "f s"     'LaTeX-fill-section
    "p"       '(nil :which-key "preview")
    "p b"     'preview-buffer
    "p c"     'preview-clearout
    "p d"     'preview-document
    "p e"     'preview-environment
    "p f"     'preview-cache-preamble
    "p s"     'preview-section
    "z"       '(nil :which-key "fold")
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
    "f r"     'LaTeX-fill-region
    "p r"     'preview-region
    "z r"     'TeX-fold-region
    ";"       'TeX-comment-or-uncomment-region))

(use-package auctex-latexmk
  :after latex
  :custom
  (auctex-latexmk-inherit-TeX-PDF-mode t)
  :config
  (auctex-latexmk-setup))

(use-package company-auctex
  :after (company latex yasnippet)
  :config
  (use-package company-math)
  :hook
  (TeX-mode . (lambda ()
   (+company-set-backends-grouped
    '(company-auctex-labels company-auctex-bibs
      company-auctex-macros company-auctex-symbols
      company-auctex-environments
      company-math-symbols-unicode
      company-math-symbols-unicode
      company-latex-commands)))))

(use-package auctex-latexmk
  :after latex
  :custom
  (auctex-latexmk-inherit-TeX-PDF-mode t)
  :hook
  (LaTeX-mode . (lambda () (setq TeX-command-default "LatexMk")))
  :config
  (auctex-latexmk-setup))
