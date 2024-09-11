;;; init-ui.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package doom-themes
  :hook
  (after-init . (lambda () (load-theme 'doom-one t)))
  :config
  (setq doom-one-brighter-comments t))

(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-support-imenu t)
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 5)
  (setq doom-modeline-minor-modes t))

(use-package diredfl
  :hook
  (dired-mode . diredfl-mode))

(use-package nerd-icons-dired
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package centaur-tabs
  :hook
  (after-init . centaur-tabs-mode)
  :config
  (setq centaur-tabs-height 20)
  (setq centaur-tabs-bar-height 20)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-icon-type 'nerd-icons))

(use-package nerd-icons-ibuffer
  :hook
  (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package winum
  :hook
  (after-init . winum-mode))

(use-package solaire-mode
  :hook
  (after-init . solaire-global-mode))

(use-package hide-mode-line
  :hook
  (treemacs-mode . turn-on-hide-mode-line-mode)
  (eshell-mode . turn-on-hide-mode-line-mode)
  (term-mode . turn-on-hide-mode-line-mode)
  (vterm-mode . turn-on-hide-mode-line-mode)
  (dired-sidebar-mode . turn-on-hide-mode-line-mode)
  (embark-collect-mode . turn-on-hide-mode-line-mode))

(use-package minions
  :hook (doom-modeline-mode . minions-mode))

(provide 'init-ui)
;;; init-ui.el ends here
