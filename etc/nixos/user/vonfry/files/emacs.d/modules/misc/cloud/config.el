;;; cloud config -*- lexical-binding: t -*-
;;

(custom! +cloud-diskdir nil
  "where is your cloud dir syncing by commands"
  :type 'directory
  :group 'vonfry-modules)

(custom! +cloud-remotedir nil
  "where is your cloud dir syncing by commands"
  :type 'directory
  :group 'vonfry-modules)

(custom! +cloud-command-dryrun-argument
  "--dry-run"
  "cloud dir sync with dryrun"
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-get-command
  "rclone sync"
  "cloud dir sync to get files command"
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-push-command
  "rclone sync"
  "cloud dir sync to push files command"
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-copy-to-command
  "rclone copy"
  "cloud dir sync to copy files to cloud"
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-copy-from-command
  "rclone copy"
  "cloud dir sync to copy files from cloud"
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-command-extra-argument ""
  "extra argument to pass."
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-push-argument (s-join " " (list +cloud-diskdir +cloud-remotedir))
  "the push argument "
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-get-argument (s-join " " (list +cloud-remotedir +cloud-diskdir))
  "the get argument "
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-copy-to-argument (s-join " " (list +cloud-diskdir +cloud-remotedir))
  "the copy to argument "
  :type 'string
  :group 'vonfry-modules)

(custom! +cloud-copy-from-argument (s-join " " (list +cloud-remotedir +cloud-diskdir))
  "the copy from argument "
  :type 'string
  :group 'vonfry-modules)
