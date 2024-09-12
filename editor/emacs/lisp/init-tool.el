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
  (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
        '(;; For reminders to change or add something at a later date.
          ("TODO" warning bold)
          ;; For code (or code paths) that are broken, unimplemented, or slow,
          ;; and may become bigger problems later.
          ("FIXME" error bold)
          ;; For code that needs to be revisited later, either to upstream it,
          ;; improve it, or address non-critical issues.
          ("REVIEW" font-lock-keyword-face bold)
          ;; For code smells where questionable practices are used
          ;; intentionally, and/or is likely to break in a future update.
          ("HACK" font-lock-constant-face bold)
          ;; For sections of code that just gotta go, and will be gone soon.
          ;; Specifically, this means the code is deprecated, not necessarily
          ;; the feature it enables.
          ("DEPRECATED" font-lock-doc-face bold)
          ;; Extra keywords commonly found in the wild, whose meaning may vary
          ;; from project to project.
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

(use-package helpful
  :bind
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key)
  ([remap describe-function] . helpful-callable)
  ("C-c C-d" . helpful-at-point))

(use-package minimap
  :config
  (setq minimap-window-location 'right)
  (setq minimap-update-delay 0.03)
  (setq minimap-width-fraction 0.09)
  (setq minimap-minimum-width 15))

(use-package quickrun
  :commands (quickrun))

(provide 'init-tool)
;;; init-tool.el ends here
