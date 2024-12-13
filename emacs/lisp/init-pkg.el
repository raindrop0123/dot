;;; init-pkg.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package doom-themes)
(use-package catppuccin-theme)
(use-package zenburn-theme)
(use-package solarized-theme)
(use-package spacemacs-theme)
(use-package monokai-theme)
(use-package molokai-theme)
(use-package dracula-theme)
(use-package material-theme)
(use-package moe-theme)
(use-package tao-theme)
(use-package sublime-themes)
(use-package ef-themes)
(use-package nord-theme)
(use-package vscode-dark-plus-theme)
(use-package color-theme-sanityinc-tomorrow)
(use-package color-theme-sanityinc-solarized)
(use-package gruvbox-theme
  :hook (after-init . (lambda() (load-theme 'gruvbox-dark-hard t))))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :hook (after-init . evil-mode)
  :config
  (setq evil-cross-lines nil)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'bar)
  (setq evil-emacs-state-cursor 'bar)
  (setq evil-visual-state-cursor 'hollow)
  (setq evil-replace-state-cursor 'hollow)
  (setq evil-mode-line-format '(before . mode-line-front-space)))

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
  :after evil ; evil-nerd-commenter must load waiting for evil-maps
  :bind
  (:map evil-normal-state-map
        ("gcc" . evilnc-comment-or-uncomment-lines))
  (:map evil-visual-state-map
        ("gc" . evilnc-comment-or-uncomment-lines)))

(use-package evil-goggles
  :hook (evil-mode . evil-goggles-mode)
  :config
  (setq evil-goggles-duration 2.500))

(use-package evil-snipe
  :hook (evil-mode . evil-snipe-override-mode))

(use-package evil-surround
  :hook (evil-mode . global-evil-surround-mode))

(use-package evil-args
  :after evil
  :bind
  (:map evil-normal-state-map
        ("L" . evil-forward-arg)
        ("H" . evil-backward-arg)))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 1)
  (setq company-echo-delay 0.2)
  (setq company-idle-delay 0.2)
  (setq company-show-numbers t)
  (setq company-require-match nil)
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case t)
  (setq company-icon-margin 3)
  (setq company-dabbrev-code-completion-styles '(basic flex))
  (setq company-format-margin-function #'company-vscode-dark-icons-margin)
  (setq company-tooltip-align-annotations t)
  (setq company-global-modes '(not eshell-mode minibuffer-inactive-mode))
  (setq company-backends
        '((company-bbdb :with company-yasnippet)
          (company-semantic :with company-yasnippet)
          (company-cmake :with company-yasnippet)
          (company-capf :with company-yasnippet)
          (company-clang :with company-yasnippet)
          (company-files :with company-yasnippet)
          (company-dabbrev-code company-gtags company-etags company-keywords :with company-yasnippet)
          (company-oddmuse :with company-yasnippet)
          (company-dabbrev :with company-yasnippet))))

(use-package company-quickhelp
  :when (display-graphic-p)
  :hook (company-mode . company-quickhelp-mode))

(use-package yasnippet
  :hook (prog-mode . yas-global-mode)
  :config
  (use-package yasnippet-snippets))

(use-package vertico
  :hook (after-init . vertico-mode)
  :bind
  (:map vertico-map
        ("RET" . vertico-directory-enter)
        ("DEL" . vertico-directory-delete-char))
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 12)
  (setq vertico-resize t)
  (setq vertico-cycle t))

(use-package marginalia
  :hook (vertico-mode . marginalia-mode))

(use-package nerd-icons-completion
  :hook (marginalia-mode . nerd-icons-completion-marginalia-setup))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :bind
  (("C-c w" . consult-ripgrep)
   ("C-c t" . consult-theme)
   ("C-x b" . consult-buffer)
   ("C-c r" . consult-history)
   ("C-c i" . consult-imenu)
   ("C-c f" . consult-flymake)
   ("C-s" . consult-line)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :config
  (setq rainbow-delimiters-max-face-count 5))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-minor-modes t)
  (setq doom-modeline-bar-width 5))

(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(use-package solaire-mode
  :hook (after-init . solaire-global-mode))

(use-package colorful-mode
  :hook (prog-mode . global-colorful-mode))

(use-package beacon
  :hook (after-init . beacon-mode)
  :config
  (setq beacon-size 60)
  (setq beacon-blink-duration 1.0)
  (setq beacon-blink-when-window-scrolls t)
  (setq beacon-blink-when-window-changes t)
  (setq beacon-blink-when-point-moves-vertically 5)
  (setq beacon-blink-when-point-moves-horizontally 5))

(use-package mode-line-bell
  :hook (after-init . mode-line-bell-mode))

(use-package indent-bars
  :hook (prog-mode . indent-bars-mode)
  :config
  (setq indent-bars-no-descend-string t)
  (setq indent-bars-prefer-character t))

(use-package diredfl
  :hook (dired-mode . diredfl-global-mode))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

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

(use-package avy
  :bind
  (("M-g w" . avy-goto-word-0)
   ("M-g l" . avy-goto-line)
   ("M-g t" . avy-goto-char-timer)))

(use-package xclip
  :hook (after-init . xclip-mode))

(use-package gcmh
  :hook (after-init . gcmh-mode))

(use-package helpful
  :bind
  (([remap describe-function] . helpful-callable)
   ([remap describe-variable] . helpful-variable)
   ([remap describe-key] . helpful-key)
   ([remap describe-command] . helpful-command)
   ("C-c C-d" . helpful-at-point)))

(use-package deadgrep
  :commands (deadgrep))

(use-package neotree
  :commands (neotree)
  :config
  (setq neo-theme 'nerd-icons))

(use-package git-gutter
  :hook (prog-mode . global-git-gutter-mode))

(use-package lua-mode
  :config
  (setq-default lua-indent-level 2)
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil))

(use-package csv-mode)
(use-package yaml-mode)
(use-package toml-mode)
(use-package markdown-mode)
(use-package haskell-mode)
(use-package ess)
(use-package quickrun)
(use-package esup)
(use-package vundo)
(use-package magit)
(use-package quickrun)

(provide 'init-pkg)
;;; init-pkg.el ends here
