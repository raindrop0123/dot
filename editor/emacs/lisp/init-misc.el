;;; init-misc.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package symbol-overlay
  :hook
  (prog-mode . symbol-overlay-mode))

(use-package xclip
  :hook
  (after-init . xclip-mode))

(provide 'init-misc)
;;; init-misc.el ends here
