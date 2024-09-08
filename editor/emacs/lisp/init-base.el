;;; init-base.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; C source code
(setq-default tab-width 2)
(setq-default truncate-lines t)
(setq-default show-trailing-whitespace t)
(setq-default lexical-binding t)

;; package.el
(setq package-check-signature nil)
(setq package-quickstart t)
(when (or (featurep 'esup-child) (daemonp) noninteractive)
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

;; simple.el
(setq-default indent-tabs-mode nil)
(add-hook 'after-init-hook #'column-number-mode)
(add-hook 'after-init-hook #'line-number-mode)
(add-hook 'after-init-hook #'size-indication-mode)

;; files.el
(add-hook 'after-init-hook #'auto-save-visited-mode)

;; icomplete.el
(add-hook 'after-init-hook #'fido-vertical-mode)

;; autorevert.el
(add-hook 'after-init-hook #'global-auto-revert-mode)

;; display-line-numbers.el
(add-hook 'after-init-hook #'global-display-line-numbers-mode)

;; display-fill-column-indicator.el
(add-hook 'after-init-hook #'global-display-fill-column-indicator-mode)

;; elec-pair.el
(add-hook 'after-init-hook #'electric-pair-mode)

;; flymake.el
(add-hook 'prog-mode-hook #'flymake-mode)

;; which-key.el
(when (featurep 'which-key)
  (add-hook 'after-init-hook #'which-key-mode))
(with-eval-after-load 'which-key
  (setq which-key-idle-delay 0.1))

;; ibuffer.el
(defalias 'list-buffers 'ibuffer)

;; dired.el
(with-eval-after-load 'dired
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-alh"))

;; whitespace.el
(setq whitespace-style '(trailing face))
(add-hook 'after-init-hook #'global-whitespace-mode)

;; so-long.el
(add-hook 'after-init-hook #'global-so-long-mode)

;; delsel.el
(add-hook 'after-init-hook #'delete-selection-mode)

;; paren.el
(add-hook 'after-init-hook #'show-paren-mode)

;; hl-line.el
(add-hook 'after-init-hook #'global-hl-line-mode)

;; isearch.el
(with-eval-after-load 'isearch
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "[%s/%s]"))

;; saveplace.el
(add-hook 'after-init-hook #'save-place-mode)

(provide 'init-base)
;;; init-base.el ends here
