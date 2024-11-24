;;; init-pkg.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :hook (after-init . evil-mode)
  :config
  (setq evil-cross-line t)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'bar)
  (setq evil-emacs-state-cursor 'bar)
  (setq evil-visual-state-cursor 'hollow)
  (setq evil-mode-line-format '(before . mode-line-front-space))
  (evil-ex-define-cmd "wq" #'(lambda () (interactive) (save-buffer) (kill-current-buffer))))

(use-package evil-escape
  :hook (evil-mode . evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2))

(use-package evil-collection
  :hook (evil-mode . evil-collection-init))

(use-package evil-matchit
  :hook (evil-mode . global-evil-matchit-mode))

(use-package evil-nerd-commenter
  :after evil ; evil-nerd-commenter must load waiting for evil-maps
  :bind
  (:map evil-normal-state-map
        ("gcc" . evilnc-comment-or-uncomment-lines))
  (:map evil-visual-state-map
        ("gc" . evilnc-comment-or-uncomment-lines)))

(use-package evil-goggles
  :hook (evil-mode . evil-goggles-mode)
  :config
  (evil-goggles-use-diff-faces)
  (setq evil-goggles-duration 2.000))

(use-package evil-visualstar
  :hook (evil-mode . global-evil-visualstar-mode))

(use-package evil-surround
  :hook (evil-mode . global-evil-surround-mode))

(use-package evil-snipe
  :hook (evil-mode . evil-snipe-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 1)
  (setq company-echo-delay 0.2)
  (setq company-idle-delay 0.2)
  (setq company-show-numbers t)
  (setq company-require-match nil)
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case t)
  (setq company-icon-margin 3)
  (setq company-dabbrev-code-completion-styles '(basic flex))
  (setq company-format-margin-function #'company-text-icons-margin)
  (setq company-tooltip-align-annotations t)
  (setq company-global-modes '(not eshell-mode minibuffer-inactive-mode))
  (setq company-backends
        '((company-bbdb :with company-yasnippet)
          (company-semantic :with company-yasnippet)
          (company-cmake :with company-yasnippet)
          (company-capf :with company-yasnippet)
          (company-clang :with company-yasnippet)
          (company-files :with company-yasnippet)
          (company-dabbrev-code company-gtags company-etags company-keywords :with company-yasnippet)
          (company-oddmuse :with company-yasnippet)
          (company-dabbrev :with company-yasnippet))))

(use-package yasnippet
  :hook (prog-mode . yas-global-mode)
  :config
  (use-package yasnippet-snippets))

(use-package vertico
  :hook (after-init . vertico-mode)
  :bind
  (:map vertico-map
        ("RET" . vertico-directory-enter)
        ("DEL" . vertico-directory-delete-char))
  :config
  (setq vertico-scroll-margin 0)
  (setq vertico-count 12)
  (setq vertico-resize t)
  (setq vertico-cycle t))

(use-package marginalia
  :hook (vertico-mode . marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :bind
  (("C-c w" . consult-ripgrep)
   ("C-c t" . consult-theme)
   ("C-c r" . consult-history)
   ("C-c i" . consult-imenu)
   ("C-s" . consult-line)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package symbol-overlay
  :hook (prog-mode . symbol-overlay-mode))

(use-package diredfl
  :hook (dired-mode . diredfl-global-mode))

(use-package diff-hl
  :hook (prog-mode-hook . global-diff-hl-mode))

(use-package git-gutter
  :hook (prog-mode . global-git-gutter-mode))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces '(("TODO" warning bold)
                                ("FIXME" error bold)
                                ("REVIEW" font-lock-keyword-face bold)
                                ("HACK" font-lock-constant-face bold)
                                ("DEPRECATED" font-lock-doc-face bold)
                                ("NOTE" success bold)
                                ("BUG" error bold)
                                ("XXX" font-lock-constant-face bold))))

(use-package beacon
  :hook (prog-mode . beacon-mode)
  :config
  (setq beacon-lighter "")
  (setq beacon-blink-when-point-moves-vertically 5)
  (setq beacon-blink-when-point-moves-horizontally 5)
  (setq beacon-blink-duration 0.5)
  (setq beacon-size 40)
  (setq beacon-blink-when-window-scrolls nil))

(use-package avy
  :bind
  (("M-g w" . avy-goto-word-0)
   ("M-g l" . avy-goto-line)
   ("M-g t" . avy-goto-char-timer)))

(use-package ace-window
  :bind
  ([remap other-window] . ace-window)
  :config
  (setq aw-background nil)
  (setq aw-char-position 'top-left)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package winum
  :hook (after-init . winum-mode)
  :config
  (setq winum-format "[%s]")
  (setq winum-mode-line-position 0))

(use-package scratch
  :bind
  (("C-c s" . scratch)))

(use-package deadgrep
  :bind
  (("C-c d" . deadgrep)))

(use-package xclip
  :hook (after-init . xclip-mode))

(use-package gcmh
  :hook (after-init . gcmh-mode))

(use-package helpful
  :bind
  (([remap describe-function] . helpful-callable)
   ([remap describe-variable] . helpful-variable)
   ([remap describe-key] . helpful-key)
   ([remap describe-command] . helpful-command)
   ("C-c C-d" . helpful-at-point)))

(use-package esup)

(provide 'init-pkg)
;;; init-pkg.el ends here
