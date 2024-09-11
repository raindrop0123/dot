;;; init-evil.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :hook
  (after-init . evil-mode))

(use-package evil-escape
  :hook
  (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2))

(use-package evil-collection
  :hook
  (evil-mode . evil-collection-init))

(use-package evil-matchit
  :hook
  (evil-mode . global-evil-matchit-mode))

(use-package evil-nerd-commenter
  :after (evil)
  :bind
  (:map evil-normal-state-map ("gcc" . evilnc-comment-or-uncomment-lines))
  (:map evil-visual-state-map ("gc" . evilnc-comment-or-uncomment-lines)))

(use-package evil-goggles
  :hook
  (evil-mode . evil-goggles-mode)
  :config
  (evil-goggles-use-diff-faces))

(provide 'init-evil)
;;; init-evil.el ends here
