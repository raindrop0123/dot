;;; init-tool.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;; avy
;; https://github.com/abo-abo/avy
(require-package 'avy)
(global-set-key (kbd "M-g l") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-0)

;; xclip
;; https://github.com/emacsmirror/xclip
(require-package 'xclip)
(add-hook 'after-init-hook #'xclip-mode)

;; hl-todo
;; https://github.com/tarsius/hl-todo
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

;; gcmh
;; https://github.com/emacsmirror/gcmh
(require-package 'gcmh)
(add-hook 'after-init-hook #'gcmh-mode)

;; diredfl
;; https://github.com/purcell/diredfl
(require-package 'diredfl)
(add-hook 'dired-mode-hook #'diredfl-mode)

;; nerd-icons-dired
;; https://github.com/rainstormstudio/nerd-icons-dired
(require-package 'nerd-icons-dired)
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

;; nerd-icons-ibuffer
;; https://github.com/seagle0128/nerd-icons-ibuffer
(require-package 'nerd-icons-ibuffer)
(add-hook 'ibuffer-mode #'nerd-icons-ibuffer-mode)

(provide 'init-tool)
;;; init-tool.el ends here
