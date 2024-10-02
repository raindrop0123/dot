;;; init-company.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(require-package 'company)
(add-hook 'prog-mode-hook #'company-mode)
(with-eval-after-load 'company
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
  (setq company-format-margin-function #'company-text-icons-margin)
  (setq company-tooltip-align-annotations t)
  (setq company-global-modes '(not eshell-mode minibuffer-inactive-mode)))

(provide 'init-company)
;;; init-company.el ends here
