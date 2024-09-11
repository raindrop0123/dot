;;; init-general.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package general
  :defer 2
  :config
  (general-create-definer
    space-leader-def
    :prefix "SPC"
    :states '(normal visual))
  (space-leader-def
    "SPC" 'execute-extended-command
    "tt" 'emacs-init-time
    "ff" 'find-file
    "fb" 'consult-buffer
    "fc" 'consult-theme
    "fw" 'consult-ripgrep
    "fo" 'consult-outline
    "fi" 'consult-imenu
    "gw" 'avy-goto-word-0
    "gl" 'avy-goto-line
    "go" 'ace-window
    "1" 'winum-select-window-1
    "2" 'winum-select-window-2
    "3" 'winum-select-window-3
    "4" 'winum-select-window-4
    "5" 'winum-select-window-5
    "6" 'winum-select-window-6
    "7" 'winum-select-window-7
    "8" 'winum-select-window-8
    "9" 'winum-select-window-9
    "0" 'winum-select-window-0-or-10))

(provide 'init-general)
;;; init-general.el ends here
