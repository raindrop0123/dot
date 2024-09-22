;;; init-ivy.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;; ivy counsel swiper
;; https://github.com/abo-abo/swiper
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

;; ivy-rich
;; https://github.com/Yevgnen/ivy-rich
(require-package 'ivy-rich)
(add-hook 'ivy-mode-hook #'ivy-rich-mode)

;; nerd-icons-ivy-rich
;; https://github.com/seagle0128/nerd-icons-ivy-rich
(require-package 'nerd-icons-ivy-rich)
(add-hook 'ivy-mode-hook #'nerd-icons-ivy-rich-mode)

;; wgrep
;; https://github.com/mhayashi1120/Emacs-wgrep
(require-package 'wgrep)
(with-eval-after-load 'wgrep
  (setq wgrep-auto-save-buffer t))

;; amx
;; https://github.com/DarwinAwardWinner/amx
(require-package 'amx)

(provide 'init-ivy)
;;; init-ivy.el ends here
