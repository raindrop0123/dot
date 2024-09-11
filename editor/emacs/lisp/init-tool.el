;;; init-tool.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package symbol-overlay
  :hook
  (prog-mode . symbol-overlay-mode))

(use-package exec-path-from-shell
  :when (eq system-type 'darwin)
  :defer 10
  :config
  (exec-path-from-shell-initialize))

(use-package avy
  :bind
  ("M-g l" . avy-goto-line)
  ("M-g w" . avy-goto-word-0))

(use-package ace-window
  :bind
  ([remap other-window] . ace-window)
  :config
  (setq aw-background nil)
  (setq aw-char-position 'top-left)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package xclip
  :hook
  (after-init . xclip-mode))

(use-package dired-sidebar
  :bind
  ("<f1>" . dired-sidebar-toggle-sidebar)
  :config
  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t)
  (setq dired-sidebar-width 30)
  (setq dired-sidebar-theme 'nerd))

(use-package hl-todo
  :hook
  (prog-mode . hl-todo-mode))

(use-package helpful
  :bind
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key)
  ([remap describe-function] . helpful-callable)
  ("C-c C-d" . helpful-at-point))

(provide 'init-tool)
;;; init-tool.el ends here
