;;; init-tool.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require-package 'rainbow-mode)
(add-hook 'prog-mode-hook #'rainbow-mode)

(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)

(require-package 'avy)
(global-set-key (kbd "M-g w") 'avy-goto-word-0)
(global-set-key (kbd "M-g l") 'avy-goto-line)

(require-package 'diredfl)
(add-hook 'dired-mode-hook #'diredfl-mode)

(require-package 'xclip)
(add-hook 'after-init-hook #'xclip-mode)

(require-package 'winum)
(add-hook 'after-init-hook #'winum-mode)

(require-package 'ace-window)
(global-set-key [remap other-window] 'ace-window)
(with-eval-after-load 'ace-window
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(require-package 'gcmh)
(add-hook 'after-init-hook #'gcmh-mode)

(require-package 'esup)

(provide 'init-tool)
;;; init-tool.el ends here
