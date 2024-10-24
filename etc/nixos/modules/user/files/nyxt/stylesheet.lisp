(in-package #:nyxt-user)

(define-configuration browser
    ((theme
      (make-instance 'theme:theme
                     ; take from daiysui dracula theme.
                     ; constrast color is mixed with black or white.
                     :monospace-font-family "monospace"
                     :font-family "sans serif"
                     :background-color  "#282a36"
                     :background-color+ "#3e3f4a"
                     :background-color- "#3e3f4a"
                     :on-background-color  nil
                     :primary-color "#ff79c6"
                     :primary-color+ "#e66db2"
                     :primary-color- "#e66db2"
                     :on-primary-color "#16050e"
                     :secondary-color "#bd93f9"
                     :secondary-color+ "#aa84e0"
                     :secondary-color- "#aa84e0"
                     :on-secondary-color "#16050e"
                     :action-color "#ffb86c"
                     :action-color+ "#e6a661"
                     :action-color- "#e6a661"
                     :on-action-color "#16050e"
                     :highlight-color "#44475a"
                     :highlight-color+ "#57596a"
                     :highlight-color- "#57596a"
                     :on-highlight-color nil
                     :success-color "#50fa7b"
                     :success-color+ "#48e16f"
                     :success-color- "#48e16f"
                     :on-success-color "#16050e"
                     :warning-color "#f1fa8c"
                     :warning-color+ "#d9e17e"
                     :warning-color- "#d9e17e"
                     :on-warning-color "#16050e"
                     :codeblock-color "#000000"
                     :codeblock-color+ "#6272a4"
                     :codeblock-color- "#6272a4"
                     :on-codeblock-color nil
                     :text-color "#f8f8f2"
                     :text-color+ "#f8f8f2"
                     :text-color- "#f8f8f2"
                     :contrast-text-color "#6272a4"))))
