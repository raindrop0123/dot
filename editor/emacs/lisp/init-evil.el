;;; init-evil.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(require-package 'evil)
(add-hook 'after-init-hook #'evil-mode)

(require-package 'evil-escape)
(add-hook 'evil-mode-hook #'evil-escape-mode)
(with-eval-after-load 'evil-escape
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2))

(require-package 'evil-collection)
(add-hook 'evil-mode-hook #'evil-collection-init)

(require-package 'evil-matchit)
(add-hook 'evil-mode-hook #'global-evil-matchit-mode)

(require-package 'evil-nerd-commenter)
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "gcc") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd "gc") 'evilnc-comment-or-uncomment-lines))

(require-package 'evil-goggles)
(add-hook 'evil-mode-hook #'evil-goggles-mode)
(with-eval-after-load 'evil-goggles
  (setq evil-goggles-duration 1.500))

(provide 'init-evil)
;;; init-evil.el ends here
