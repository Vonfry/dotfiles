;;; latex packages -*- lexical-binding: t -*-
;;

(package! latex
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
  (TeX-view-program-selection (vonfry-system-sets
                               (gnu/linux '((output-pdf "zathura")
                                            (output-dvi "xdvi")
                                            (output-html "xdg-open")))
                                (darwin    '((output-pdf "open")
                                             (output-dvi "open")
                                             (output-html "open")))))
  ;; Synctex support
  ;; Don't insert line-break at inline math
  (TeX-show-compilation t) ; display compilation windows
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-method 'synctex)
  (reftex-citation-format 'biblatex)
  :hook
  (LaTeX-mode .
     (lambda ()
       (custom-set! compile-command "latexmk")
       (require 'preview)
       (require 'tex-site)
       ;; use pdfview with auctex
       ;; have the buffer refresh after compilation
       (reftex-mode)
       (rainbow-delimiters-mode)
       (LaTeX-math-mode)))
  :general
  (:keymaps 'TeX-mode-map
    (kbd "TAB") 'TeX-complete-symbol)
  (+mmap-tex-def
    "?"   'TeX-doc
    "RET" 'preview-at-point
    "r"   'compile
    "R"   'TeX-command-run-all)
  (+mmap-mode-tex-def
    "\\"    'TeX-insert-macro
    "-"     'TeX-recenter-output-buffer
    "%"     'TeX-comment-or-uncomment-paragraph
    ";"     'TeX-comment-or-uncomment-region
    "k"     'TeX-kill-job
    "l"     'TeX-recenter-output-buffer
    "m"     'TeX-insert-macro
    "v"     'TeX-view
    "C"     'TeX-clean
    "n"     'TeX-narrow-to-group
    "*"     'LaTeX-mark-section
    "."     'LaTeX-mark-environment
    "c"     'LaTeX-close-environment
    "e"     'LaTeX-environment
    "i"     'LaTeX-insert-item
    "s"     'LaTeX-section
    "f"     '(nil :which-key "fill")
    "f e"   'LaTeX-fill-environment
    "f p"   'LaTeX-fill-paragraph
    "f r"   'LaTeX-fill-region
    "f s"   'LaTeX-fill-section
    "p"     '(nil :which-key "preview")
    "p b"   'preview-buffer
    "p c"   'preview-clearout
    "p d"   'preview-document
    "p e"   'preview-environment
    "p f"   'preview-cache-preamble
    "p r"   'preview-region
    "p s"   'preview-section
    "z"     '(nil :which-key "fold")
    "z ="   'TeX-fold-math
    "z b"   'TeX-fold-buffer
    "z e"   'TeX-fold-env
    "z m"   'TeX-fold-macro
    "z r"   'TeX-fold-region
    "rc"    'reftex-citation
    "rg"    'reftex-grep-document
    "ri"    'reftex-index-selection-or-word
    "rI"    'reftex-display-index
    "r TAB" 'reftex-index
    "rl"    'reftex-label
    "rp"    'reftex-index-phrase-selection-or-word
    "rP"    'reftex-index-visit-phrases-buffer
    "rr"    'reftex-reference
    "rs"    'reftex-search-document
    "rt"    'reftex-toc
    "rT"    'reftex-toc-recenter
    "rv"    'reftex-view-crossref))

(package! auctex-latexmk
  :after latex
  :custom
  (auctex-latexmk-inherit-TeX-PDF-mode t)
  :config
  (auctex-latexmk-setup))

(package! company-math
 :after company
 :config
 (add-to-list 'company-backends 'company-math-symbols-unicode))

(package! company-auctex
  :after (company latex yasnippet)
  :hook
  (TeX-mode . company-auctex-init))

(package! auctex-latexmk
  :after latex
  :custom
  (auctex-latexmk-inherit-TeX-PDF-mode t)
  :hook
  (LaTeX-mode . (lambda () (setq TeX-command-default "LatexMk")))
  :config
  (auctex-latexmk-setup))
