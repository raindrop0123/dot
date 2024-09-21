;;; init-pkgs.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :hook (after-init . evil-mode)
  :config
  (setq evil-cross-lines t))

(use-package evil-escape
  :hook (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2))

(use-package evil-collection
  :hook (evil-mode . evil-collection-init))

(use-package evil-matchit
  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-nerd-commenter
  :after (evil)
  :bind
  (:map evil-normal-state-map ("gcc" . evilnc-comment-or-uncomment-lines))
  (:map evil-visual-state-map ("gc" . evilnc-comment-or-uncomment-lines)))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 1)
  (setq company-echo-delay 0.2)
  (setq company-idle-delay 0.2)
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package symbol-overlay
  :hook
  (prog-mode . symbol-overlay-mode))

(use-package lua-mode
  :mode (("\\.lua$" . lua-mode))
  :config
  (setq lua-indent-level 2)
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil))

(use-package csv-mode)
(use-package vimrc-mode)

(use-package avy
  :bind
  ("M-g l" . avy-goto-line)
  ("M-g w" . avy-goto-word-0))

(use-package xclip
  :hook (after-init . xclip-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
        '(("TODO" warning bold)
          ("FIXME" error bold)
          ("REVIEW" font-lock-keyword-face bold)
          ("HACK" font-lock-constant-face bold)
          ("DEPRECATED" font-lock-doc-face bold)
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

(use-package helpful
  :bind
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key)
  ([remap describe-function] . helpful-callable)
  ("C-c C-d" . helpful-at-point))

(use-package gcmh
  :hook (after-init . gcmh-mode))

(use-package quickrun
  :commands (quickrun))

(use-package diredfl
  :hook (dired-mode . diredfl-mode))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package nerd-icons-completion
  :when (display-graphic-p)
  :hook (after-init . nerd-icons-completion-mode))

(use-package marginalia
  :hook (after-init . marginalia-mode))

(use-package indent-bars
  :hook (prog-mode . indent-bars-mode))

(provide 'init-pkgs)
;;; init-pkgs.el ends here
