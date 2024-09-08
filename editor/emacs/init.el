;;; init.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun add-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))
(advice-add #'package-initialize :after #'add-load-path)
(add-load-path)

(let ((gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      (file-name-handler-alist nil))
  (require 'init-core)
  (require 'init-evil)
  (require 'init-company)
  (require 'init-minibuffer)
  (require 'init-tool))

(run-with-idle-timer
 4 nil
 #'(lambda ()
     (setq gc-cons-threshold 67108864) ; 64M
     (setq gc-cons-percentage 0.1) ; original value
     (garbage-collect)))

(message "[Emacs] Loaded in %s with %d garbage collections."
         (format "%.2f seconds" (float-time (time-subtract after-init-time before-init-time)))
         gcs-done)

(provide 'init)
;;; init.el ends here
