;;; latex config -*- lexical-binding: t -*-

(load "auctex") ;; this package hasn't called (provide).

(vonfry|use-package! latex
  :after company
  :config
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'TeX-mode-hook 'LaTeX-math-mode)
  (dolist (mode-hook '(TeX-mode-hook LaTeX-mode-hook))
    (add-hook mode-hook
      (lambda()
        (require 'preview)
        (require 'tex-site)
        (custom-set-variables
         '(TeX-source-correlate-mode t))
        (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
        (setq TeX-auto-untabify t     ; remove all tabs before saving
              TeX-engine 'xetex       ; use xelatex default
              TeX-auto-save t
              TeX-parse-self t
              TeX-auto-private (expand-file-name "tex/" vonfry-local-dir)
              TeX-syntactic-comment t
              ;; Synctex support
              TeX-source-correlate-start-server nil
              ;; Don't insert line-break at inline math
              LaTeX-fill-break-at-separators nil
              auctex-latexmk-inherit-TeX-PDF-mode t
              TeX-show-compilation t) ; display compilation windows
        (setq TeX-save-query nil)
        (imenu-add-menubar-index)
        (nmap :keymaps 'local
              :prefix +lang-nmap-prefix
              "\\"  'TeX-insert-macro
              "-"   'TeX-recenter-output-buffer
              "%"   'TeX-comment-or-uncomment-paragraph
              ";"   'TeX-comment-or-uncomment-region
              "a"   'TeX-command-run-all
              "b"   'latex/build
              "k"   'TeX-kill-job
              "l"   'TeX-recenter-output-buffer
              "m"   'TeX-insert-macro
              "v"   'TeX-view
              "d"   'TeX-doc
              "b"   'latex/font-bold
              "tc"  'latex/font-code
              "te"  'latex/font-emphasis
              "fi"  'latex/font-italic
              "r"   'latex/font-clear
              "o"   'latex/font-oblique
              "fc"  'latex/font-small-caps
              "ff"  'latex/font-sans-serif
              "fr"  'latex/font-serif
              "*"   'LaTeX-mark-section
              "."   'LaTeX-mark-environment
              "c"   'LaTeX-close-environment)
          (nmap :keymaps 'local
              :prefix +lang-nmap-prefix
              "e"   'LaTeX-environment
              "ii"  'LaTeX-insert-item
              "s"   'LaTeX-section
              "fe"  'LaTeX-fill-environment
              "fp"  'LaTeX-fill-paragraph
              "fr"  'LaTeX-fill-region
              "fs"  'LaTeX-fill-section
              "pb"  'preview-buffer
              "pc"  'preview-clearout
              "pd"  'preview-document
              "pe"  'preview-environment
              "pf"  'preview-cache-preamble
              "pp"  'preview-at-point
              "pr"  'preview-region
              "ps"  'preview-section
              "B"   'latex/font-medium
              "r"   'latex/font-clear
              "fa"  'latex/font-calligraphic
              "fn"  'latex/font-normal
              "fu"  'latex/font-upright)
            (when latex-enable-folding
              (nmap :keymaps 'local
                    :prefix +lang-nmap-prefix
                    "z=" 'TeX-fold-math
                    "zb" 'TeX-fold-buffer
                    "ze" 'TeX-fold-env
                    "zm" 'TeX-fold-macro
                    "zr" 'TeX-fold-region))))))

(vonfry|use-package! auctex-latexmk
  :after latex
  :config
  (add-hook 'LaTeX-mode-hook 'auctex-latexmk-setup)
  (add-hook 'TeX-mode-hook 'auctex-latexmk-setup))

(vonfry|use-package! company-math
 :after company
 :config
 (add-to-list (make-local-variable 'company-backends) 'company-math-symbols-unicode))


(vonfry|use-package! company-auctex
  :after company latex
  :config
  (add-hook 'TeX-mode-hook 'company-auctex-init)
  (add-hook 'LaTeX-mode-hook 'company-auctex-init))
