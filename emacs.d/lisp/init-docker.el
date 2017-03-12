(require-package 'docker)
(require-package 'dockerfile-mode)

(add-hook 'evil-local-mode-hook
  (lambda ()
    (evil-leader/set-key
      "Cc" 'docker-containers
      "Cd" 'docker-rmi
      "Ce" 'docker-unpause
      "CF" 'docker-pull
      "Ck" 'docker-rm
      "Ci" 'docker-images
      "Co" 'docker-stop
      "CP" 'docker-push
      "Cp" 'docker-pause
      "Cr" 'docker-restart
      "Cs" 'docker-start)
    (with-eval-after-load 'docker-containers
      (evilified-state-evilify-map docker-containers-mode-map
        :mode docker-containers-mode))
    (with-eval-after-load 'docker-images
      (evilified-state-evilify-map docker-images-mode-map
        :mode docker-images-mode))
    (evil-leader/set-key-for-mode 'dockerfile-mode
      "mcb" 'dockerfile-build-buffer)))
(provide 'init-docker)
