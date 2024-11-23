;;; init-pkg.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;;; EVIL ;;;
(require-package 'evil)
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(add-hook 'after-init-hook #'evil-mode)
(with-eval-after-load 'evil
  (setq evil-cross-lines t)
  (setq evil-normal-state-cursor 'box)
  (setq evil-insert-state-cursor 'bar)
  (setq evil-emacs-state-cursor 'bar)
  (setq evil-visual-state-cursor 'hollow)
  (evil-ex-define-cmd "wq" #'(lambda () (interactive) (save-buffer) (kill-current-buffer))))

(require-package 'evil-collection)
(add-hook 'evil-mode-hook #'evil-collection-init)

(require-package 'evil-escape)
(add-hook 'evil-mode-hook #'evil-escape-mode)
(with-eval-after-load 'evil-escape
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2))

(require-package 'evil-matchit)
(add-hook 'evil-mode-hook #'global-evil-matchit-mode)

(require-package 'evil-nerd-commenter)
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "gcc") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd "gc") 'evilnc-comment-or-uncomment-lines))

(require-package 'evil-goggles)
(add-hook 'evil-mode-hook #'evil-goggles-mode)
(with-eval-after-load 'evil-goggles
  (evil-goggles-use-diff-faces)
  (setq evil-goggles-duration 2.000))

(require-package 'evil-visualstar)
(add-hook 'evil-mode-hook #'global-evil-visualstar-mode)

(require-package 'evil-surround)
(add-hook 'evil-mode-hook #'global-evil-surround-mode)

(require-package 'evil-args)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)
  (define-key evil-motion-state-map "L" 'evil-forward-arg)
  (define-key evil-motion-state-map "H" 'evil-backward-arg))

(require-package 'evil-snipe)
(add-hook 'evil-mode-hook #'evil-snipe-mode)

;;; COMPLETION ;;;
(require-package 'company)
(add-hook 'prog-mode-hook #'company-mode)
(with-eval-after-load 'company
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

(require-package 'company-box)
(when (display-graphic-p)
  (add-hook 'company-mode-hook #'company-box-mode))

;;; SYNTAX CHECKING ;;;
(require-package 'flycheck)
(add-hook 'prog-mode-hook #'global-flycheck-mode)
(global-set-key (kbd "M-n") 'flycheck-next-error)
(global-set-key (kbd "M-n") 'flycheck-previous-error)

;;; IVY ;;;
(require-package 'ivy)
(add-hook 'after-init-hook #'ivy-mode)
(with-eval-after-load 'ivy
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 13)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "[%d/%d]")
  (setq ivy-re-builders-alist `((t . ivy--regex-ignore-order))))

(require-package 'ivy-rich)
(add-hook 'ivy-mode-hook #'ivy-rich-mode)

(require-package 'nerd-icons-ivy-rich)
(add-hook 'ivy-mode-hook #'nerd-icons-ivy-rich-mode)

(require-package 'counsel)
(add-hook 'ivy-mode-hook #'counsel-mode)
(global-set-key (kbd "M-g w") 'counsel-rg)
(global-set-key (kbd "M-g f") 'counsel-flycheck)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(require-package 'swiper)
(global-set-key (kbd "C-s") 'swiper-isearch)

(require-package 'amx)

(require-package 'wgrep)
(with-eval-after-load 'wgrep
  (setq wgrep-auto-save-buffer t))

;;; UI ;;;
(require-package 'doom-themes)
(add-hook 'after-init-hook
          #'(lambda ()
              (setq doom-one-brighter-comments t)
              (load-theme 'doom-one t)))

(require-package 'doom-modeline)
(add-hook 'after-init-hook #'doom-modeline-mode)
(with-eval-after-load 'doom-modeline
  (setq doom-modeline-support-imenu t)
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 5)
  (setq doom-modeline-minor-modes t))

(require-package 'minions)
(add-hook 'doom-modeline-mode-hook #'minions-mode)

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require-package 'centaur-tabs)
(add-hook 'after-init-hook #'centaur-tabs-mode)
(with-eval-after-load 'centaur-tabs
  (setq centaur-tabs-height 32)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-icon-type 'nerd-icons))

(require-package 'hl-todo)
(add-hook 'prog-mode-hook #'hl-todo-mode)
(with-eval-after-load 'hl-todo
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces '(("TODO" warning bold)
                                ("FIXME" error bold)
                                ("REVIEW" font-lock-keyword-face bold)
                                ("HACK" font-lock-constant-face bold)
                                ("DEPRECATED" font-lock-doc-face bold)
                                ("NOTE" success bold)
                                ("BUG" error bold)
                                ("XXX" font-lock-constant-face bold))))

(require-package 'beacon)
(add-hook 'prog-mode-hook #'beacon-mode)
(with-eval-after-load 'beacon
  (setq beacon-lighter "")
  (setq beacon-blink-when-point-moves-vertically 5)
  (setq beacon-blink-when-point-moves-horizontally 5)
  (setq beacon-blink-duration 0.5)
  (setq beacon-size 40)
  (setq beacon-blink-when-window-scrolls nil))

(require-package 'solaire-mode)
(add-hook 'after-init-hook #'solaire-global-mode)

(require-package 'hide-mode-line)
(add-hook 'eshell-mode #'hide-mode-line-mode)
(add-hook 'shell-mode #'hide-mode-line-mode)
(add-hook 'term-mode #'hide-mode-line-mode)
(add-hook 'lsp-ui-imenu-mode #'hide-mode-line-mode)

;;; TOOL ;;;
(require-package 'xclip)
(add-hook 'after-init-hook #'xclip-mode)

(require-package 'rainbow-mode)
(add-hook 'prog-mode-hook #'rainbow-mode)

(require-package 'scratch)
(global-set-key (kbd "C-c s") 'scratch)

(require-package 'helpful)
(global-set-key (kbd "C-h f") 'helpful-callable)
(global-set-key (kbd "C-h v") 'helpful-variable)
(global-set-key (kbd "C-h k") 'helpful-key)
(global-set-key (kbd "C-h x") 'helpful-command)
(global-set-key (kbd "C-c C-d") 'helpful-at-point)

(require-package 'ace-window)
(global-set-key [remap other-window] 'ace-window)
(with-eval-after-load 'ace-window
  (setq aw-background nil)
  (setq aw-char-position 'top-left)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(require-package 'winum)
(add-hook 'after-init-hook #'winum-mode)
(with-eval-after-load 'winum
  (setq winum-format "[%s]")
  (setq winum-mode-line-position 0))

(require-package 'neotree)
(global-set-key (kbd "<f1>") #'neotree-toggle)
(with-eval-after-load 'neotree
  (setq neo-theme 'nerd-icons))

(require-package 'eshell-syntax-highlighting)
(add-hook 'eshell-mode-hook #'eshell-syntax-highlighting-global-mode)

(require-package 'avy)
(global-set-key (kbd "M-g w") 'avy-goto-word-0)
(global-set-key (kbd "M-g l") 'avy-goto-line)
(global-set-key (kbd "M-g t") 'avy-goto-char-timer)

(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)

(require-package 'gcmh)
(add-hook 'after-init-hook #'gcmh-mode)

(require-package 'general)
(general-evil-setup t)
(general-create-definer space-leader-def
  :prefix "SPC"
  :states '(normal visual))
(space-leader-def
  "tt" 'emacs-init-time
  "1" 'winum-select-window-1
  "2" 'winum-select-window-2
  "3" 'winum-select-window-3
  "4" 'winum-select-window-4
  "5" 'winum-select-window-5
  "6" 'winum-select-window-6
  "7" 'winum-select-window-7
  "8" 'winum-select-window-8
  "9" 'winum-select-window-9
  "0" 'winum-select-window-0-or-10
  "wd" 'delete-other-windows
  "wD" 'delete-window
  "rs" 'pp-macroexpand-last-sexp
  "re" 'eval-last-sexp
  "rr" 'quickrun
  "hk" 'helpful-key
  "hx" 'helpful-command
  "hv" 'helpful-variable
  "hf" 'helpful-callable
  "bk" 'kill-current-buffer
  "ww" 'ace-window
  "gw" 'avy-goto-word-0
  "gl" 'avy-goto-line
  "gt" 'avy-goto-char-timer
  "SPC" 'counsel-M-x
  "fc" 'counsel-load-theme
  "ff" 'counsel-find-file
  "fb" 'counsel-ibuffer
  "fw" 'counsel-rg)

(require-package 'indent-bars)
(add-hook 'prog-mode-hook #'indent-bars-mode)

(require-package 'minimap)
(with-eval-after-load 'minimap
  (setq minimap-width-fraction 0.10)
  (setq minimap-minimum-width 10)
  (setq minimap-window-location 'right))

(require-package 'nerd-icons-ibuffer)
(add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)

(require-package 'nerd-icons-dired)
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

(require-package 'diredfl)
(add-hook 'dired-mode-hook #'diredfl-global-mode)

(require-package 'diff-hl)
(add-hook 'prog-mode-hook #'global-diff-hl-mode)

(require-package 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (run-with-idle-timer 10 nil 'exec-path-from-shell-initialize))

(require-package 'git-gutter)
(add-hook 'prog-mode-hook #'global-git-gutter-mode)

(require-package 'visual-regexp)
(require-package 'deadgrep)
(require-package 'writeroom-mode)
(require-package 'esup)
(require-package 'quickrun)
(require-package 'vundo)
(require-package 'magit)
(require-package 'vterm)

;;; LANGUAGE ;;;
(require-package 'lua-mode)
(with-eval-after-load 'lua-mode
  (setq lua-indent-level 2)
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil))

(require-package 'prettier-js)
(add-hook 'js2-mode-hook #'prettier-js-mode)
(add-hook 'web-mode-hook #'prettier-js-mode)

(require-package 'ess)
(require-package 'scss-mode)
(require-package 'markdown-mode)
(require-package 'vimrc-mode)
(require-package 'typescript-mode)
(require-package 'js2-mode)
(require-package 'web-mode)
(require-package 'yaml-mode)
(require-package 'toml-mode)
(require-package 'json-mode)
(require-package 'csv-mode)
(require-package 'go-mode)
(require-package 'zig-mode)

;;; LSP & DAP ;;;
(require-package 'lsp-mode)
(require-package 'lsp-ui)
(require-package 'lsp-ivy)
(require-package 'dap-mode)

;;; SNIPPET ;;;
(require-package 'yasnippet)
(require-package 'yasnippet-snippets)
(add-hook 'prog-mode-hook #'yas-global-mode)

(provide 'init-pkg)
;;; init-pkg.el ends here
