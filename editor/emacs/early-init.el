;;; early-init.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;; Package initialize occurs automatically, before `user-init-file' is loaded, but after `early-init-file'.
;; We handle package initialization, so we must prevent Emacs from doing it early!
(when (or (featurep 'esup-child)
          (daemonp)
          noninteractive)
  (setq package-enable-at-startup nil))

;; Adjust garbage collection
(setq gc-cons-percentage 0.6)
(setq gc-cons-threshold most-positive-fixnum)

;; Initial major mode for startup faster
(setq initial-major-mode 'fundamental-mode)

;; Disable autosave and backup
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq make-backup-files nil)

;; Custom file
(setq custom-file (locate-user-emacs-file "custom.el"))

;; Inhibit resizing frame and startup message
(setq inhibit-startup-message t)
(setq frame-inhibit-implied-resize t)

;; Faster to disable these here before they've been initialized
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)
(when (featurep 'ns)
  (push '(ns-transparent-titlebar . t) default-frame-alist))

(provide 'early-init)
;;; early-init.el ends here
