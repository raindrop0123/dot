;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-

;;; Reference:
;; https://github.com/redguardtoo/emacs.d
;; https://github.com/seagle0128/.emacs.d
;; https://github.com/manateelazycat/lazycat-emacs
;; https://github.com/purcell/emacs.d
;; https://github.com/bbatsov/prelude
;; https://github.com/doomemacs/doomemacs
;; https://github.com/MiniApollo/kickstart.emacs
;; https://github.com/SystemCrafters/crafted-emacs
;; https://github.com/jamescherti/minimal-emacs.d
;; https://github.com/LionyxML/emacs-kick
;; https://protesilaos.com/codelog/2024-11-28-basic-emacs-configuration/

;;; Commentary:
;;; Code:

(let* ((minimum-version "30.0"))
  (when (version< emacs-version minimum-version)
    (error "Emacs v%s or higher is required" minimum-version)))

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
