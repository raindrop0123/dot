;;; init-base.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package use-package
  :ensure nil
  :custom
  (use-package-always-ensure t)
  (use-package-always-defer t)
  (use-package-expand-minimally t)
  (use-package-enable-imenu-support t)
  (use-package-verbose t))

(use-package package
  :ensure nil
  :config
  (setq package-check-signature nil)
  (setq package-quickstart t)
  (when (or (featurep 'esup-child)
            (daemonp)
            noninteractive)
    (package-initialize))
  (setq package-archives
        '(;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
          ;; ("org" . "https://orgmode.org/elpa/")
          ;; ("marmalade" . "http://marmalade-repo.org/packages/")
          ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
          ("gnu" . "https://elpa.gnu.org/packages/")
          ("melpa" . "https://melpa.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package emacs
  :ensure nil
  :config
  (setq-default tab-width 2)
  (setq-default truncate-lines t)
  (setq completion-ignore-case t)
  (add-hook 'minibuffer-setup-hook #'(lambda() (setq gc-cons-threshold most-positive-fixnum)))
  (add-hook 'minibuffer-exit-hook #'(lambda() (setq gc-cons-threshold 800000)))
  (when (eq system-type 'darwin)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier 'super)))

(use-package which-key
  :ensure nil
  :hook (after-init . which-key-mode))

(use-package loaddefs
  :ensure nil
  :hook (prog-mode . global-completion-preview-mode))

(use-package simple
  :ensure nil
  :hook
  (prog-mode . column-number-mode)
  (prog-mode . line-number-mode)
  (prog-mode . size-indication-mode)
  :config
  (setq-default indent-tabs-mode nil)
  (setq completion-auto-select 'second-tab)
  (setq blink-matching-paren-highlight-offscreen t))

(use-package frame
  :ensure nil
  :hook (after-init . blink-cursor-mode)
  :config
  (setq blink-cursor-blinks 0)
  (setq blink-cursor-interval 0.3))

(use-package files
  :ensure nil
  :hook (after-init . auto-save-visited-mode)
  :config
  (setq auto-mode-case-fold nil))

(use-package autorevert
  :ensure nil
  :hook (after-init . global-auto-revert-mode))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'relative))

(use-package display-fill-column-indicator
  :ensure nil
  :hook (prog-mode . display-fill-column-indicator-mode)
  :config
  (setq-default display-fill-column-indicator-column 80))

(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))

(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . 'ibuffer)
  :config
  (setq ibuffer-filter-group-name-face 'font-lock-doc-face))

(use-package dired
  :ensure nil
  :config
  (setq-default dired-dwim-target t)
  (setq dired-listing-switches "-alGhv --group-directories-first")
  (setq dired-recursive-copies 'always)
  (setq dired-kill-when-opening-new-dired-buffer t))

(use-package whitespace
  :hook (prog-mode . whitespace-mode)
  :config
  (setq whitespace-style '(trailing face)))

(use-package so-long
  :ensure nil
  :hook (after-init . global-so-long-mode))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t)
  (setq show-paren-when-point-in-periphery t)
  (setq show-paren-context-when-offscreen t)
  (setq show-paren-delay 0.2))

(use-package hl-line
  :ensure nil
  :hook (prog-mode . hl-line-mode)
  :config
  (setq hl-line-range-function (lambda() (cons (line-end-position) (line-beginning-position 2)))))

(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

(use-package isearch
  :ensure nil
  :config
  (setq isearch-lazy-count t)
  (setq isearch-allow-motion t)
  (setq isearch-motion-changes-direction t))

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator " • ")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))

(use-package minibuffer
  :ensure nil
  :hook (after-init . minibuffer-depth-indicate-mode)
  :config
  (setq read-file-name-completion-ignore-case t)
  (setq inhibit-message-regexps '("^Saving file" "^Wrote"))
  (setq set-message-functions '(inhibit-message)))

(use-package winner
  :ensure nil
  :hook (after-init . winner-mode))

(use-package tooltip
  :ensure nil
  :config
  (setq tooltip-delay 1.5))

(use-package flymake
  :ensure nil
  :hook (prog-mode . flymake-mode)
  :bind
  (("M-n" . flymake-goto-next-error)
   ("M-p" . flymake-goto-prev-error)))

(use-package prog-mode
  :ensure nil
  :hook (prog-mode . global-prettify-symbols-mode))

(provide 'init-base)
;;; init-base.el ends here
