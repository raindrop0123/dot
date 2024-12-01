;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))
(advice-add #'package-initialize :after #'update-load-path)
(update-load-path)

(let ((gc-cons-threshold most-positive-fixnum)
      (gc-cons-percentage 0.6)
      (file-name-handler-alist nil))
  (require 'init-base)
  (require 'init-pkg))

(provide 'init)
;;; init.el ends here
