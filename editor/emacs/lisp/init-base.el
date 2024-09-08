;;; init-base.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package use-package
  :custom
  (use-package-always-ensure t)
  (use-package-always-defer t)
  (use-package-expand-minimally t)
  (use-package-enable-imenu-support t))

(use-package package
  :custom
  (package-check-signature nil)
  (package-quickstart t)
  :config
  (package-initialize)
  (setq package-archives
        '(;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
          ;; ("org" . "https://orgmode.org/elpa/")
          ;; ("marmalade" . "http://marmalade-repo.org/packages/")
          ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
          ("gnu" . "https://elpa.gnu.org/packages/")
          ("melpa" . "https://melpa.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package modus-themes
  :ensure nil
  :hook
  (after-init . (lambda () (load-theme 'modus-vivendi t))))

(use-package simple
  :ensure nil
  :hook
  (after-init . column-number-mode)
  (after-init . line-number-mode)
  (after-init . size-indication-mode)
  :config
  (setq-default indent-tabs-mode nil))

(use-package files
  :ensure nil
  :hook
  (after-init . auto-save-visited-mode))

(use-package icomplete
  :ensure nil
  :hook
  (after-init . fido-vertical-mode))

(use-package autorevert
  :ensure nil
  :hook
  (after-init . global-auto-revert-mode))

(use-package display-line-numbers
  :ensure nil
  :hook
  (prog-mode . display-line-numbers-mode))

(use-package display-fill-column-indicator
  :ensure nil
  :hook
  (prog-mode . display-fill-column-indicator-mode))

(use-package elec-pair
  :ensure nil
  :hook
  (prog-mode . electric-pair-mode))

(use-package flymake
  :ensure nil
  :hook
  (prog-mode . flymake-mode))

(use-package which-key
  :ensure nil
  :hook
  (after-init . which-key-mode)
  :config
  (setq which-key-idle-delay 0.4))

(use-package ibuffer
  :ensure nil
  :init
  (defalias 'list-buffers 'ibuffer))

(use-package dired
  :ensure nil
  :config
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-alh"))

(use-package whitespace
  :custom
  (whitespace-style '(trailing face))
  :hook
  (prog-mode . whitespace-mode))

(use-package so-long
  :ensure nil
  :hook
  (after-init . global-so-long-mode))

(use-package delsel
  :ensure nil
  :hook
  (after-init . delete-selection-mode))

(use-package paren
  :ensure nil
  :hook
  (after-init . show-paren-mode))

(use-package hl-line
  :ensure nil
  :hook
  (prog-mode . hl-line-mode))

(use-package isearch
  :ensure nil
  :config
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "[%s/%s]"))

(use-package saveplace
  :ensure nil
  :hook
  (after-init . save-place-mode))

(provide 'init-base)
;;; init-base.el ends here
