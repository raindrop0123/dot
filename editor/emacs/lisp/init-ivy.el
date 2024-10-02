;;; init-ivy.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(require-package 'ivy)
(require-package 'counsel)
(require-package 'swiper)
(add-hook 'after-init-hook #'ivy-mode)
(add-hook 'ivy-mode-hook #'counsel-mode)
(with-eval-after-load 'ivy
  (setq ivy-use-virutal-buffers t)
  (setq ivy-height 12)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format " [%d/%d] ")
  (setq ivy-re-builders-alist `((t . ivy--regex-ignore-order))))
(global-set-key (kbd "C-s") 'counsel-grep-or-swiper)

(require-package 'ivy-rich)
(add-hook 'ivy-mode-hook #'ivy-rich-mode)

(require-package 'nerd-icons-ivy-rich)
(add-hook 'ivy-mode-hook #'nerd-icons-ivy-rich-mode)

(require-package 'wgrep)
(with-eval-after-load 'wgrep
  (setq wgrep-auto-save-buffer t))

(require-package 'amx)

(provide 'init-ivy)
;;; init-ivy.el ends here
