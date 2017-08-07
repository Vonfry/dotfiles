;;; docker config -*- lexical-binding: t -*-

(vonfry|use-package! docker
  :init
  (defcustom +docker-nmap-prefix
    (concat vonfry-keybind-evil-leader "v")
    "docker nmap prefix"
    :group 'vonfry-module)
  :config
  (vonfry-system-sets
    '(darwin
     (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
     (setq exec-path (append exec-path '("/usr/local/bin")))
     ;; Use "docker-machine env box" command to find out your environment variables
     (setenv "DOCKER_TLS_VERIFY" "1")
     (setenv "DOCKER_HOST" "tcp://10.11.12.13:2376")
     (setenv "DOCKER_CERT_PATH" "/Users/foo/.docker/machine/machines/box")
     (setenv "DOCKER_MACHINE_NAME" "box")))
  (docker-global-mode t)
  :general
  (nmap :prefix +docker-nmap-prefix )
      "c" 'docker-containers
      "d" 'docker-rmi
      "e" 'docker-unpause
      "F" 'docker-pull
      "k" 'docker-rm
      "i" 'docker-images
      "o" 'docker-stop
      "P" 'docker-push
      "p" 'docker-pause
      "r" 'docker-restart
      "s" 'docker-start)
