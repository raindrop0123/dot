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
  (require 'init-editor))

(provide 'init)
;;; init.el ends here
