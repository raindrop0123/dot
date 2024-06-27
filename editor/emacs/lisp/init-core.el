;;; init-core.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun set-gui-font ()
  (interactive)
  (when (display-graphic-p)
    (cl-loop for font in '("JetBrainsMono Nerd Font"
                           "UbuntuMono Nerd Font"
                           "Hack Nerd Font"
                           "SF Mono"
                           "Menlo"
                           "Monaco"
                           "Consolas")
             when (find-font (font-spec :name font))
             return (set-face-attribute 'default nil :family font :height 140))
    (cl-loop for font in '("LXGW WenKai Mono"
                           "WenQuanYi Micro Hei"
                           "PingFang TC"
                           "Microsoft Yahei"
                           "STFangsong")
             when (find-font (font-spec :name font))
             return (progn
                      (setq face-font-rescale-alist `((,font . 1.2)))
                      (set-fontset-font t '(#x4e00 . #x9fff) (font-spec :family font))))))
(add-hook 'window-setup-hook #'set-gui-font)

(setq package-check-signature nil)
(setq package-quickstart t)
(when (or (featurep 'esup-child)
          (daemonp)
          noninteractive)
  (package-initialize))
(setq package-archives
      '(;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ;; ("org" . "https://orgmode.org/elpa/")
        ;; ("marmalade" . "http://marmalade-repo.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))
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

(add-hook 'after-init-hook #'(lambda() (load-theme 'modus-vivendi t)))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-hook 'after-init-hook #'column-number-mode)
(add-hook 'after-init-hook #'line-number-mode)
(add-hook 'after-init-hook #'size-indication-mode)
(add-hook 'after-init-hook #'auto-save-visited-mode)
(add-hook 'after-init-hook #'global-auto-revert-mode)
(add-hook 'after-init-hook #'global-display-line-numbers-mode)
(add-hook 'after-init-hook #'global-display-fill-column-indicator-mode)
(add-hook 'after-init-hook #'electric-pair-mode)
(add-hook 'prog-mode-hook #'flymake-mode)
(defalias 'list-buffers 'ibuffer)
(with-eval-after-load 'dired
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-alh"))
(setq show-trailing-whitespace t)
(setq whitespace-style '(trailing face))
(add-hook 'after-init-hook #'global-whitespace-mode)
(add-hook 'after-init-hook #'global-so-long-mode)
(add-hook 'after-init-hook #'delete-selection-mode)
(add-hook 'after-init-hook #'show-paren-mode)
(add-hook 'after-init-hook #'global-hl-line-mode)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "[%s/%s]")
(add-hook 'after-init-hook #'save-place-mode)
(add-hook 'after-init-hook #'global-tab-line-mode)
(setq-default line-spacing 0.4)

(provide 'init-core)
;;; init-core.el ends here
