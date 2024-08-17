;;; init-minibuffer.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'vertico)
(add-hook 'after-init-hook #'vertico-mode)
(with-eval-after-load 'vertico
  (setq vertico-count 12)
  (setq vertico-resize t)
  (setq vertico-cycle t)
  (define-key minibuffer-mode-map (kbd "DEL") 'vertico-directory-delete-char))

(require-package 'orderless)
(with-eval-after-load 'minibuffer
  (setq completion-styles '(orderless basic))
  (setq completion-category-overrides '((file (styles basic partial-completion)))))

(require-package 'consult)
(global-set-key (kbd "C-s") 'consult-line)
(global-set-key (kbd "C-x C-b") 'consult-buffer)
(global-set-key (kbd "C-c C-r") 'consult-ripgrep)
(global-set-key (kbd "C-c C-o") 'consult-outline)

(require-package 'marginalia)
(add-hook 'after-init-hook #'marginalia-mode)

(require-package 'embark)
(require-package 'embark-consult)

(provide 'init-minibuffer)
;;; init-minibuffer.el ends here
