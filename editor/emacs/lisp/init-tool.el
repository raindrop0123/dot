;;; init-misc.el --- -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)

(require-package 'xclip)
(add-hook 'after-init-hook #'xclip-mode)

(provide 'init-misc)
;;; init-misc.el ends here
