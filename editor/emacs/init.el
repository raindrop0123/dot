;;; init.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(defun require-init (pkg &optional maybe-disabled)
  "Load PKG if `maybe-disabled' is nil
or it's nil but start up in normal slowly."
  (when (not maybe-disabled)
    (load (file-truename (format "%s/%s" (concat (file-name-as-directory user-emacs-directory) "lisp") pkg)) t t)))

(let ((gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      (file-name-handler-alist nil))
  (require-init 'init-base)
  (require-init 'init-evil)
  (require-init 'init-company)
  (require-init 'init-misc))

(run-with-idle-timer
 4 nil
 #'(lambda ()
     (setq gc-cons-threshold 67108864)
     (setq gc-cons-percentage 0.1)
     (garbage-collect)))

(message "[Emacs] Loaded in %s with %d garbage collections."
         (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
         gcs-done)

(provide 'init)
;;; init.el ends here
