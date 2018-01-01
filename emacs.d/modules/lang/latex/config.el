;;; latex config -*- lexical-binding: t -*-

(load "auctex") ;; this package hasn't called (provide).

(use-package! latex
  :after company
  :config
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'TeX-mode-hook 'LaTeX-math-mode)
  (dolist (mode-hook '(TeX-mode-hook LaTeX-mode-hook))
    (add-hook mode-hook
      (lambda()
        (custom-set-variables
          '(compile-command "xelatex")
          '(TeX-source-correlate-mode t))
        (require 'preview)
        (require 'tex-site)
        ;; use pdfview with auctex
        ;; have the buffer refresh after compilation
        (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
        (custom-set-variables
         '(reftex-plug-into-AUCTeX t)
         '(TeX-auto-untabify t)
         '(TeX-engine 'xetex)
         '(TeX-master nil)
         '(TeX-auto-save t)
         '(TeX-save-query nil)
         '(TeX-parse-self t)
         '(TeX-auto-private (expand-file-name "tex/" vonfry-local-dir))
         '(TeX-PDF-mode t)
         '(TeX-view-program-selection '((output-pdf "PDF Tools")))
         '(TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
         '(TeX-syntactic-comment t)
         '(TeX-source-correlate-start-server nil)
         '(TeX-source-correlate-method 'synctex)
         ;; Synctex support
         ;; Don't insert line-break at inline math
         '(LaTeX-fill-break-at-separators nil)
         '(auctex-latexmk-inherit-TeX-PDF-mode t)
         '(TeX-show-compilation t) ; display compilation windows
         '(TeX-source-correlate-mode t))
        (turn-on-reftex)
        (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)
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

(use-package! auctex-latexmk
  :after latex
  :config
  (add-hook 'LaTeX-mode-hook 'auctex-latexmk-setup)
  (add-hook 'TeX-mode-hook 'auctex-latexmk-setup))

(use-package! company-math
 :after company
 :config
 (add-to-list (make-local-variable 'company-backends) 'company-math-symbols-unicode))


(use-package! company-auctex
  :after company latex yasnippet
  :config
  (add-hook 'TeX-mode-hook 'company-auctex-init)
  (add-hook 'LaTeX-mode-hook 'company-auctex-init))
