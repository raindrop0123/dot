;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'.
Don't put large files in `site-lisp' directory.
Otherwise the startup will be very slow."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(advice-add #'package-initialize :after #'update-load-path)
;;(advice-add #'package-initialize :after #'add-subdirs-to-load-path)
(update-load-path)

(let ((gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      (file-name-handler-alist nil))
  (require 'init-base)
  (require 'init-evil)
  (require 'init-completion)
  (require 'init-ui)
  (require 'init-tool)
  (require 'init-general))

(run-with-idle-timer
 4 nil
 #'(lambda ()
     (setq gc-cons-threshold 67108864)
     (setq gc-cons-percentage 0.1)
     (garbage-collect)))

(message "[Emacs] Loaded in %s with %d garbage collections."
         (format "%.6f seconds" (float-time (time-subtract after-init-time before-init-time)))
         gcs-done)

(provide 'init)
;;; init.el ends here
