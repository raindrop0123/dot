;;; init-tool.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(require-package 'catppuccin-theme)
(add-hook 'after-init-hook #'(lambda () (load-theme 'catppuccin t)))
(with-eval-after-load 'catppuccin-theme
  (setq catppuccin-flavor 'mocha)
  (setq catppuccin-italic-comments t)
  (setq catppuccin-italic-variables t)
  (catppuccin-set-color 'base "#000000")
  (catppuccin-set-color 'mantle "#000000")
  (catppuccin-set-color 'crust "#000000")
  (custom-set-faces '(line-number-current-line ((t (:foreground "#a6e3a1" :weight bold))))))
(run-with-idle-timer 2 nil #'catppuccin-reload)

(require-package 'avy)
(global-set-key (kbd "M-g l") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-0)

(require-package 'xclip)
(add-hook 'after-init-hook #'xclip-mode)

(require-package 'hl-todo)
(add-hook #'prog-mode-hook #'hl-todo-mode)
(with-eval-after-load 'hl-todo
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
        '(("TODO" warning bold)
          ("FIXME" error bold)
          ("REVIEW" font-lock-keyword-face bold)
          ("HACK" font-lock-constant-face bold)
          ("DEPRECATED" font-lock-doc-face bold)
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

(require-package 'rainbow-mode)
(add-hook 'prog-mode-hook #'rainbow-mode)

(require-package 'gcmh)
(add-hook 'after-init-hook #'gcmh-mode)

(require-package 'diredfl)
(add-hook 'dired-mode-hook #'diredfl-mode)

(require-package 'nerd-icons-dired)
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

(require-package 'nerd-icons-ibuffer)
(add-hook 'ibuffer-mode #'nerd-icons-ibuffer-mode)

(require-package 'esup)

(provide 'init-tool)
;;; init-tool.el ends here
