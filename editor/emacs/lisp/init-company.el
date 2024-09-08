;;; init-company.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package company
  :hook
  (after-init . global-company-mode)
  :config
  (setq company-global-modes '(not erc-mode message-mode eshell-mode))
  (setq company-format-margin-function #'company-detect-icons-margin)
  (setq company-idle-delay 0.1)
  (setq company-require-match nil)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  (setq company-eclim-auto-save nil)
  (setq company-dabbrev-downcase nil)
  (setq company-show-numbers t))

(use-package company-box
  :hook
  (company-mode . company-box-mode)
  :config
  (setq company-box-backends-colors nil)
  (setq company-box-frame-behavior 'point)
  (setq company-box-scrollbar 'right)
  (setq company-box-doc-delay 0.3)
  (setq company-box-doc-text-scale-level -2))

(provide 'init-company)
;;; init-company.el ends here
