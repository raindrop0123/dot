;;; init-base.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;; C source code
(setq-default tab-width 2)
(setq-default enable-recursive-minibuffers t)

;; package.el
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
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE with MIN-VERSION.
If NO-REFRESH is nil, `package-refresh-contents' is called."
  (unless (featurep 'package)
    (condition-case nil
        (require 'package)
      (error nil)))
  (unless (package-installed-p package min-version)
    (unless (or (assoc package package-archive-contents) no-refresh)
      (message "Missing package: %s" package)
      (package-refresh-contents))
    (package-install package)))

;; modus-themes.el
(add-hook 'after-init-hook #'(lambda () (load-theme 'modus-vivendi t)))

;; simple.el
(add-hook 'prog-mode-hook #'column-number-mode)
(add-hook 'prog-mode-hook #'line-number-mode)
(add-hook 'prog-mode-hook #'size-indication-mode)
(with-eval-after-load 'simple
  (setq-default indent-tabs-mode nil)
  (setq idle-update-delay 1.0)
  (setq completion-auto-select 'second-tab))

;; frame.el
(add-hook 'after-init-hook #'blink-cursor-mode)
(with-eval-after-load 'frame
  (setq blink-cursor-blinks 0))

;; files.el
(add-hook 'after-init-hook #'auto-save-visited-mode)
(with-eval-after-load 'files
  (setq auto-mode-case-fold nil))

;; autorevert.el
(add-hook 'after-init-hook #'global-auto-revert-mode)

;; display-line-numbers.el
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(with-eval-after-load 'display-line-numbers
  (setq display-line-numbers 'relative))

;; display-fill-column-indicator.el
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; elec-pair.el
(add-hook 'prog-mode-hook #'electric-pair-mode)

;; which-key.el
(add-hook 'after-init-hook #'which-key-mode)

;; ibuffer.el
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; dired.el
(with-eval-after-load 'dired
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-alh"))

;; whitespace.el
(add-hook 'prog-mode-hook #'whitespace-mode)
(with-eval-after-load 'whitespace
  (setq whitespace-style '(trailing face)))

;; so-long.el
(add-hook 'after-init-hook #'global-so-long-mode)

;; delsel.el
(add-hook 'after-init-hook #'delete-selection-mode)

;; paren.el
(add-hook 'after-init-hook #'show-paren-mode)

;; hl-line.el
(add-hook 'prog-mode-hook #'hl-line-mode)

;; saveplace.el
(add-hook 'after-init-hook #'save-place-mode)

(provide 'init-base)
;;; init-base.el ends here
