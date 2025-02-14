;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:

;;; References:
;; https://github.com/seagle0128/.emacs.d
;; https://github.com/bbatsov/prelude
;; https://github.com/redguardtoo/emacs.d
;; https://github.com/manateelazycat/lazycat-emacs
;; https://github.com/MiniApollo/kickstart.emacs
;; https://github.com/doomemacs/doomemacs
;; https://github.com/purcell/emacs.d
;; https://github.com/SystemCrafters/crafted-emacs

;;; Code:

(use-package use-package
  :custom
  (use-package-always-ensure t)
  (use-package-always-defer t)
  (use-package-expand-minimally t)
  (use-package-enable-imenu-support t))

(use-package package
  :ensure nil
  :custom
  (package-enable-at-startup nil)
  :config
  (when (or (featurep 'esup-child)
            (daemonp)
            noninteractive)
    (package-initialize))
  (setq package-check-signature nil)
  (setq package-quickstart t)
  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
                           ;; ("org" . "https://orgmode.org/elpa/")
                           ;; ("marmalade" . "http://marmalade-repo.jrg/packages/")
                           ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
                           ;; ("jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/")
                           ("gnu" . "https://elpa.gnu.org/packages/")
                           ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

(use-package emacs
  :ensure nil
  :config
  (setq gc-cons-threshold most-positive-fixnum)
  (setq gc-cons-percentage 0.6)
  (setq frame-inhibit-implied-resize t)
  (setq-default bidi-display-reordering nil)
  (setq-default bidi-inhibit-bpa t)
  (setq ring-bell-function #'ignore)
  (setq-default long-line-threshold 500)
  (setq-default large-hscroll-threshold 500)
  (setq-default fast-but-imprecise-scolling t)
  (setq-default inhibit-compacting-font-caches t)
  (setq-default read-process-output-max (* 64 1024))
  (setq-default highlight-nonselected-windows nil)
  (setq-default redisplay-skip-fontification-on-input t)
  (setq-default cursor-in-non-selected-windows nil)
  (setq-default enable-recursive-minibuffers t)
  (setq-default bidi-paragraph-direction 'left-to-right)
  (setq-default tab-width 2)
  (setq-default truncate-lines t)
  (setq-default completion-ignore-case t)
  (setq-default resize-mini-windows t)
  (setq-default use-short-answers t)
  (setq-default default-frame-alist
                '((menu-bar-lines . 0)
                  (tool-bar-lines . 0)
                  (vertical-scroll-bars)
                  (horizontal-scroll-bars))))

(use-package modus-themes
  :ensure nil
  :hook (after-init . (lambda () (load-theme 'modus-vivendi t))))

(use-package pixel-scroll
  :ensure nil
  :hook (after-init . pixel-scroll-precision-mode))

(use-package startup
  :ensure nil
  :hook
  (window-setup . (lambda ()
                    (cl-loop for font in '("JetbrainsMono Nerd Font" "SF Mono" "Monaco" "Menlo" "Consolas")
                             when (find-font (font-spec :name font))
                             return (set-face-attribute 'default nil :family font :height 140))))
  :custom
  (auto-save-list-file-prefix nil)
  (initial-major-mode 'fundamental-mode)
  (inhibit-startup-message t)
  (initial-scratch-message
   (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n\n")))

(use-package cus-edit
	:ensure nil
	:custom
	(custom-file (locate-user-emacs-file "custom.el")))

(use-package which-key
	:ensure nil
	:defer 5
	:config
  (setq which-key-idle-delay 0.3)
  (setq which-key-show-docstrings t)
	(which-key-mode))

(use-package tab-line
  :ensure nil
  :init
  (setq tab-line-close-button-show nil)
  (setq tab-line-new-button-show nil)
  :hook (after-init . global-tab-line-mode))

(use-package simple
	:ensure nil
	:hook
	(prog-mode . column-number-mode)
	(prog-mode . line-number-mode)
	(prog-mode . size-indication-mode)
	:config
	(setq-default indent-tabs-mode nil)
  (setq blink-matching-paren-highlight-offscreen t))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode))

(use-package frame
  :ensure nil
  :hook (after-init . blink-cursor-mode)
  :config
  (setq blink-cursor-blinks 0)
  (setq blink-cursor-interval 0.3))

(use-package files
  :ensure nil
  :hook (after-init . auto-save-visited-mode)
  :config
  (setq auto-save-default nil)
  (setq make-backup-files nil)
  (setq auto-mode-case-fold nil))

(use-package repeat
  :ensure nil
  :hook (after-init . repeat-mode)
  :config
  (setq repeat-exit-key (kbd "RET")))

(use-package autorevert
  :ensure nil
  :hook (after-init . global-auto-revert-mode))

(use-package display-fill-column-indicator
  :ensure nil
  :hook (prog-mode . display-fill-column-indicator-mode)
  :config
  (setq-default display-fill-column-indicator-column 80))

(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))

(use-package ibuffer
  :ensure nil
  :bind (("C-x C-b" . ibuffer)))

(use-package dired
  :ensure nil
  :config
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-alGhv --group-directories-first")
  (setq dired-recursive-copies 'always)
  (setq dired-kill-when-opening-new-dired-buffer t))

(use-package whitespace
  :ensure nil
  :hook (prog-mode . whitespace-mode)
  :config
  (setq whitespace-style '(trailing face)))

(use-package so-long
  :ensure nil
  :hook (after-init . global-so-long-mode))

(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t)
  (setq show-paren-when-point-in-periphery t)
  (setq show-paren-context-when-offscreen t)
  (setq show-paren-delay 0.2))

(use-package hl-line
  :ensure nil
  :hook (prog-mode . hl-line-mode))

(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

(use-package isearch
  :ensure nil
  :config
  (setq isearch-lazy-count t)
  (setq isearch-allow-motion t)
  (setq isearch-motion-changes-direction t))

(use-package minibuffer
  :ensure nil
  :hook (after-init . minibuffer-depth-indicate-mode)
  :config
  (setq read-file-name-completion-ignore-case t))

(use-package treesit
  :ensure nil
  :defer 20
  :config
  (setq treesit-language-source-alist
        '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
          (c . ("https://github.com/tree-sitter/tree-sitter-c"))
          (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
          (css . ("https://github.com/tree-sitter/tree-sitter-css"))
          (cmake . ("https://github.com/uyha/tree-sitter-cmake"))
          (csharp . ("https://github.com/tree-sitter/tree-sitter-c-sharp.git"))
          (dockerfile . ("https://github.com/camdencheek/tree-sitter-dockerfile"))
          (elisp . ("https://github.com/Wilfred/tree-sitter-elisp"))
          (elixir "https://github.com/elixir-lang/tree-sitter-elixir" "main" "src" nil nil)
          (go . ("https://github.com/tree-sitter/tree-sitter-go"))
          (gomod . ("https://github.com/camdencheek/tree-sitter-go-mod.git"))
          (haskell "https://github.com/tree-sitter/tree-sitter-haskell" "master" "src" nil nil)
          (html . ("https://github.com/tree-sitter/tree-sitter-html"))
          (java . ("https://github.com/tree-sitter/tree-sitter-java.git"))
          (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
          (json . ("https://github.com/tree-sitter/tree-sitter-json"))
          (lua . ("https://github.com/Azganoth/tree-sitter-lua"))
          (make . ("https://github.com/alemuller/tree-sitter-make"))
          (markdown . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown/src"))
          (markdown-inline . ("https://github.com/tree-sitter-grammars/tree-sitter-markdown" "split_parser" "tree-sitter-markdown-inline/src"))
          (ocaml . ("https://github.com/tree-sitter/tree-sitter-ocaml" nil "ocaml/src"))
          (org . ("https://github.com/milisims/tree-sitter-org"))
          (python . ("https://github.com/tree-sitter/tree-sitter-python"))
          (php . ("https://github.com/tree-sitter/tree-sitter-php"))
          (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "typescript/src"))
          (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" nil "tsx/src"))
          (ruby . ("https://github.com/tree-sitter/tree-sitter-ruby"))
          (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
          (sql . ("https://github.com/m-novikov/tree-sitter-sql"))
          (scala "https://github.com/tree-sitter/tree-sitter-scala" "master" "src" nil nil)
          (toml "https://github.com/tree-sitter/tree-sitter-toml" "master" "src" nil nil)
          (vue . ("https://github.com/merico-dev/tree-sitter-vue"))
          (kotlin . ("https://github.com/fwcd/tree-sitter-kotlin"))
          (yaml . ("https://github.com/ikatyang/tree-sitter-yaml"))
          (zig . ("https://github.com/GrayJack/tree-sitter-zig"))
          (clojure . ("https://github.com/sogaiu/tree-sitter-clojure"))
          (nix . ("https://github.com/nix-community/nix-ts-mode"))
          (mojo . ("https://github.com/HerringtonDarkholme/tree-sitter-mojo")))))

(use-package flymake
  :hook
  (prog-mode . flymake-mode)
  :bind
  (("M-n" . flymake-goto-next-error)
   ("M-p" . flymake-goto-prev-error)))

(provide 'init)
;;; init.el ends here
