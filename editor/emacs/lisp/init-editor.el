;;; init-editor.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require-package 'rainbow-mode)
(add-hook 'prog-mode-hook #'rainbow-mode)

(require-package 'avy)
(global-set-key (kbd "M-g w") 'avy-goto-word-0)
(global-set-key (kbd "M-g l") 'avy-goto-line)

(require-package 'which-key)
(add-hook 'after-init-hook #'which-key-mode)

(provide 'init-editor)
;;; init-editor.el ends here
