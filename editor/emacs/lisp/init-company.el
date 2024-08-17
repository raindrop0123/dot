;;; init-company.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (setq company-global-modes '(not erc-mode message-mode eshell-mode))
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  (setq company-show-numbers t))

(provide 'init-company)
;;; init-company.el ends here
