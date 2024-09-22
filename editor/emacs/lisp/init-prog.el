;;; init-prog.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;; flycheck
;; https://github.com/flycheck/flycheck
(require-package 'flycheck)
(add-hook 'prog-mode-hook #'global-flycheck-mode)
(global-set-key (kbd "M-n") 'flycheck-next-error)
(global-set-key (kbd "M-p") 'flycheck-previous-error)

;; rainbow-delimiters
;; https://github.com/Fanael/rainbow-delimiters
(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; symbol-overlay
;; https://github.com/wolray/symbol-overlay
(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)

;; lua-mode
;; https://github.com/immerrr/lua-mode
(require-package 'lua-mode)
(with-eval-after-load 'lua-mode
  (setq lua-indent-level 2)
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil))

;; csv-mode
;; https://github.com/emacsmirror/csv-mode
(require-package 'csv-mode)

(provide 'init-prog)
;;; init-prog.el ends here
