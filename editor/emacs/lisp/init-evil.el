;;; init-evil.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(require-package 'evil)
(add-hook 'after-init-hook #'evil-mode)
(with-eval-after-load 'evil
  (setq evil-normal-state-message "")
  (setq evil-emacs-state-message "")
  (setq evil-insert-state-message "")
  (setq evil-replace-state-message "")
  (setq evil-motion-state-message "")
  (setq evil-visual-state-message "")
  (setq evil-operator-state-message "")
  (setq evil-normal-state-tag (propertize " NORMAL " 'face '((:background "#2fafff" :foreground "#000000"))))
  (setq evil-emacs-state-tag (propertize " EMACS " 'face '((:background "#f78fe7" :foreground "#000000"))))
  (setq evil-insert-state-tag (propertize " INSERT " 'face '((:background "#ff5f59" :foreground "#000000"))))
  (setq evil-replace-state-tag (propertize " REPLACE " 'face '((:background "#fec43f" :foreground "#000000"))))
  (setq evil-motion-state-tag (propertize " MOTION " 'face '((:background "#9ac8e0" :foreground "#000000"))))
  (setq evil-visual-state-tag (propertize " VISUAL " 'face '((:background "#70b900" :foreground "#000000"))))
  (setq evil-operator-state-tag (propertize " OPERATOR " 'face '((:background "#ff66ff" :foreground "#000000"))))
  (setq evil-mode-line-format '(before . mode-line-front-space)))

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
