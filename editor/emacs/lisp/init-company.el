;;; init-company.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (setq company-global-modes '(not erc-mode message-mode eshell-mode))
  (setq company-format-margin-function #'company-detect-icons-margin)
  (setq company-idle-delay 0.1)
  (setq company-require-match nil)
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  (setq company-eclim-auto-save nil)
  (setq company-dabbrev-downcase nil)
  (setq company-show-numbers t)
  (setq company-backends
        (append
         '(company-capf company-semantic)
         '(company-keywords)
         '(company-abbrev company-dabbrev company-dabbrev-code)
         '(company-files company-path)
         '(company-etags company-gtags)
         '(company-yasnippet))))

(require-package 'company-box)
(add-hook 'company-mode-hook #'company-box-mode)
(with-eval-after-load 'company-box
  (setq company-box-backends-colors nil)
  (setq company-box-frame-behavior 'point)
  (setq company-box-scrollbar 'right)
  (setq company-box-doc-delay 0.3)
  (setq company-box-doc-text-scale-level -2))

(provide 'init-company)
;;; init-company.el ends here
