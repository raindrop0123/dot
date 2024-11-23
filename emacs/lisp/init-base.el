;;; init-base.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;; emacs - C source code
(setq-default line-spacing 0.1)
(setq-default garbage-collection-messages t)
(setq-default tab-width 2)
(setq completion-ignore-case t)
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
  "Ask elpa to install given PACKAGE with `MIN-VERSION'.
If `NO-REFRESH' is nil, `package-refresh-contents' is called."
  (unless (featurep 'package)
    (condition-case nil
        (require 'package)
      (error nil)))
  (unless (package-installed-p package min-version)
    (unless (or (assoc package package-archive-contents) no-refresh)
      (message "Missing package: %s" package)
      (package-refresh-contents))
    (package-install package)))
(font-lock-add-keywords
 'emacs-lisp-mode '(("\\<require-package\\>" . font-lock-builtin-face)))

;; which-key.el
(add-hook 'after-init-hook #'which-key-mode)

;; simple.el
(add-hook 'prog-mode-hook #'column-number-mode)
(add-hook 'prog-mode-hook #'line-number-mode)
(add-hook 'prog-mode-hook #'size-indication-mode)
(with-eval-after-load 'simple
	(setq-default indent-tabs-mode nil)
  (setq idle-update-delay 1.0)
  (setq read-buffer-completion-ignore-case t)
  (setq enable-recursive-minibuffers t)
  (setq completion-auto-select 'second-tab))

;; frame.el
(add-hook 'after-init-hook #'blink-cursor-mode)
(with-eval-after-load 'frame
  (setq blink-cursor-blinks 0)
  (setq blink-cursor-interval 0.3))

;; startup.el
(setq initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n\n"))

;; files.el
(add-hook 'after-init-hook #'auto-save-visited-mode)
(with-eval-after-load 'files
  (setq auto-mode-case-fold nil))
(global-unset-key (kbd "C-x C-c"))

;; autorevert.el
(add-hook 'after-init-hook #'global-auto-revert-mode)

;; display-line-numbers.el
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(with-eval-after-load 'display-line-numbers
  (setq display-line-numbers-type 'relative))

;; display-fill-column-indicator.el
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(with-eval-after-load 'display-fill-column-indicator
  (setq-default display-fill-column-indicator-column 80))

;; elec-pair.el
(add-hook 'prog-mode-hook #'electric-pair-mode)

;; ibuffer.el
(global-set-key (kbd "C-x C-b") 'ibuffer)
(with-eval-after-load 'ibuffer
  (setq ibuffer-filter-group-name-face 'font-lock-doc-face))

;; dired.el
(with-eval-after-load 'dired
  (setq-default dired-dwim-target t)
  (setq dired-listing-switches "-alGhv --group-directories-first")
  (setq dired-recursive-copies 'always)
  (setq dired-kill-when-opening-new-dired-buffer t))

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

;; isearch.el
(with-eval-after-load 'isearch
  (setq isearch-lazy-count t)
  (setq isearch-allow-motion t)
  (setq isearch-motion-changes-direction t))

;; uniquify.el
(with-eval-after-load 'uniquify
  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator " • ")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))

;; minibuffer.el
(add-hook 'after-init-hook #'minibuffer-depth-indicate-mode)
(with-eval-after-load 'minibuffer
  (setq read-file-name-completion-ignore-case t)
  (setq inhibit-message-regexps '("^Saving file" "^Wrote"))
  (setq set-message-functions '(inhibit-message)))

;; winner.el
(add-hook 'after-init-hook #'winner-mode)

;; tooltip.el
(with-eval-after-load 'tooltip
  (setq tooltip-delay 1.5))

(provide 'init-base)
;;; init-base.el ends here
