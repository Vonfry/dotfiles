;;; cloud config -*- lexical-binding: t -*-
;;

(defcustom +cloud-diskdir
  (getenv "CLOUDDISK_DIR")
  "where is your cloud dir syncing by commands"
  :type 'directory
  :group 'vonfry-modules)

(defcustom +cloud-command-dryrun-argument
  "--dry-run"
  "cloud dir sync with dryrun"
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-get-command
  "rclone sync"
  "cloud dir sync to get files command"
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-push-command
  "rclone sync"
  "cloud dir sync to push files command"
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-copy-to-command
  "rclone copy"
  "cloud dir sync to copy files to cloud"
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-copy-from-command
  "rclone copy"
  "cloud dir sync to copy files from cloud"
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-command-extra-argument ""
  "extra argument to pass."
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-push-argument (s-join " " (list +cloud-diskdir "cloud:cfg"))
  "the push argument "
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-get-argument (s-join " " (list "cloud:cfg" +cloud-diskdir))
  "the get argument "
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-copy-to-argument (s-join " " (list +cloud-diskdir "cloud:cfg"))
  "the copy to argument "
  :type 'string
  :group 'vonfry-modules)

(defcustom +cloud-copy-from-argument (s-join " " (list "cloud:cfg" +cloud-diskdir))
  "the copy from argument "
  :type 'string
  :group 'vonfry-modules)
