;;; init-completion.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package vertico
  :hook
  (after-init . vertico-mode)
  :bind
  (:map vertico-map ("RET" . vertico-directory-enter))
  (:map vertico-map ("DEL" . vertico-directory-delete-char))
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 12)
  (setq vertico-resize t)
  (setq vertico-cycle t))

(use-package nerd-icons-completion
  :when
  (display-graphic-p)
  :hook
  (vertico-mode . nerd-icons-completion-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :hook
  (after-init . marginalia-mode))

(use-package consult
  :bind
  ("C-s" . consult-line)
  ("C-x C-b" . consult-buffer)
  ("C-c h" . consult-history)
  ("C-c I" . consult-info)
  ("C-c r" . consult-ripgrep)
  ("C-c T" . consult-theme)
  ("C-c i" . consult-imenu)
  ("C-c f" . describe-face)
  ("M-g f" . consult-flymake)
  ("M-g g" . consult-goto-line)
  (:map minibuffer-local-map ("M-s" . consult-history))
  (:map minibuffer-local-map ("M-r" . consult-history)))

(use-package embark
  :bind
  ("C-." . embark-act)
  (:map minibuffer-mode-map ("C-;" . embark-export)))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep
  :commands wgrep-change-to-wgrep-mode
  :bind
  (:map grep-mode-map ("C-c C-q" . wgrep-change-to-wgrep-mode))
  :config
  (setq wgrep-auto-save-buffer t))

(use-package corfu
  :hook
  (after-init . global-corfu-mode)
  (global-corfu-mode . corfu-popupinfo-mode)
  :config
  (setq corfu-auto t)
  (setq corfu-auto-prefix 1)
  (setq corfu-auto-delay 0.3)
  (setq corfu-preview-current nil)
  (setq corfu-popupinfo-delay '(0.4 . 0.2)))

(use-package corfu-terminal
  :when (not (display-graphic-p))
  :hook
  (global-corfu-mode . corfu-terminal-mode))

(use-package nerd-icons-corfu
  :hook
  (global-corfu-mode . (lambda () (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))))

(use-package cape
  :hook
  (global-corfu-mode . (lambda () (add-to-list 'completion-at-point-functions #'cape-dabbrev)))
  (global-corfu-mode . (lambda () (add-to-list 'completion-at-point-functions #'cape-file)))
  (global-corfu-mode . (lambda () (add-to-list 'completion-at-point-functions #'cape-elisp-block)))
  (global-corfu-mode . (lambda () (add-to-list 'completion-at-point-functions #'cape-keyword)))
  (global-corfu-mode . (lambda () (add-to-list 'completion-at-point-functions #'cape-abbrev))))

(provide 'init-completion)
;;; init-completion.el ends here
