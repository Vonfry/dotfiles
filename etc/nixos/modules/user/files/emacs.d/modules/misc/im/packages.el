;;; im packages -*- lexical-binding: t -*-
;;

(use-package erc
  :init
  (load +irc-local-file t t)
  :custom
  (erc-log-channel-directory (expand-file-name "erc/log" vonfry-local-dir))
  (erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "NICK" "PART" "QUIT"))
  (erc-lurker-threshold-time 600)
  :general
  (nmap-at
    "i"   'erc-switch-to-buffer
    "I"   '(:ignore t :which-key "irc")
    "I i" '+irc/connect
    "I I" 'erc-tls
    "I l" 'erc-log-enable
    "I e" 'erc))

(use-package telega
  :custom
  (telega-directory (expand-file-name "telega" vonfry-cache-dir))
  (telega-database-dir (expand-file-name "telega" vonfry-local-dir))
  (telega-open-file-function 'org-open-file)
  (telega-msg-save-dir (xdg-user-dir "DOWNLOAD"))
  (telega-open-message-as-file '(photo video audio video-note voice-note animation))

  ; We have to hard code them to make some images showing in daemon.
  (telega-use-images '(scale rotate90))
  (telega-emoji-font-family "Noto Color Emoji")
  (telega-emoji-use-images "Noto Color Emoji")
  (telega-online-status-function 'telega-focus-state)
  (telega-completing-read-function 'ivy-completing-read)
  :hook
  ((telega-load . telega-notifications-mode)
   (server-after-make-frame .
     (lambda (&rest _)
       (dolist (symbl '(telega-use-images telega-emoji-font-family
                        telega-emoji-use-images telega-online-status-function))
         (set symbl (eval (car (get symbl 'standard-value))))))))
  :general
  (nmap-at
    "t" telega-prefix-map))

(use-package telega-dired-dwim :after telega)
