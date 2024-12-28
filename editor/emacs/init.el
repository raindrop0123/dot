;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-

;;; Reference:
;; https://github.com/redguardtoo/emacs.d
;; https://github.com/seagle0128/.emacs.d
;; https://github.com/manateelazycat/lazycat-emacs
;; https://github.com/purcell/emacs.d
;; https://github.com/bbatsov/prelude
;; https://github.com/doomemacs/doomemacs
;; https://github.com/MiniApollo/kickstart.emacs
;; https://github.com/SystemCrafters/crafted-emacs
;; https://github.com/jamescherti/minimal-emacs.d
;; https://github.com/LionyxML/emacs-kick
;; https://protesilaos.com/codelog/2024-11-28-basic-emacs-configuration/

;;; Commentary:
;;; Code:

;; C source code
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)
(setq frame-inhibit-implied-resize t)
(setq-default bidi-display-reordering nil)
(setq-default bidi-inhibit-bpa t)
(setq-default long-line-threshold 500)
(setq-default large-hscroll-threshold 500)
(setq-default fast-but-imprecise-scolling t)
(setq-default inhibit-compacting-font-caches t)
(setq-default read-process-output-max (* 64 1024))
(setq-default highlight-nonselected-windows nil)
(setq-default redisplay-skip-fontification-on-input t)
(setq-default cursor-in-non-selected-windows nil)
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
                (horizontal-scroll-bars)))
(add-hook 'minibuffer-setup-hook #'(lambda() (setq gc-cons-threshold most-positive-fixnum)))
(add-hook 'minibuffer-exit-hook #'(lambda() (setq gc-cons-threshold 800000)))

;; startup.el
(setq auto-save-list-file-prefix nil)
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message
      (concat
       ";; Happy hacking, "
       user-login-name
       " - Emacs ♥ you!\n\n"))
(setq inhibit-startup-message t)

;; mule-cmds.el
(set-language-environment 'UTF-8)
(setq default-input-method nil)

;; package.el
(when (or (featurep 'esup-child)
          (daemonp)
          noninteractive)
  (setq package-enable-at-startup nil))
(setq-default package-check-signature nil)
(setq-default package-quickstart t)
(when (or (featurep 'esup-child)
          (daemonp)
          noninteractive)
  (package-initialize))
(setq-default package-archives
              '(;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
                ;; ("org" . "https://orgmode.org/elpa/")
                ;; ("marmalade" . "http://marmalade-repo.org/packages/")
                ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
                ;; ("jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/")
                ("gnu" . "https://elpa.gnu.org/packages/")
                ("melpa" . "https://melpa.org/packages/")
                ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; which-key.el
(add-hook 'after-init-hook #'which-key-mode)

;; simple.el
(add-hook 'prog-mode-hook #'column-number-mode)
(add-hook 'prog-mode-hook #'line-number-mode)
(add-hook 'prog-mode-hook #'size-indication-mode)
(with-eval-after-load 'simple
  (setq-default indent-tabs-mode nil)
  (setq blink-matching-paren-highlight-offscreen t))

;; frame.el
(add-hook 'after-init-hook #'blink-cursor-mode)
(with-eval-after-load 'frame
  (setq blink-cursor-blinks 0)
  (setq blink-cursor-interval 0.3))

;; cus-edit.el
(setq custom-file (locate-user-emacs-file "custom.el"))
;; (when (file-exists-p custom-file) (load custom-file))

;; icomplete.el
(add-hook 'after-init-hook #'icomplete-vertical-mode)

;; files.el
(add-hook 'after-init-hook #'auto-save-visited-mode)
(with-eval-after-load 'files
  (setq auto-save-default nil)
  (setq make-backup-files nil)
  (setq auto-mode-case-fold nil))

;; autorevert.el
(add-hook 'after-init-hook #'global-auto-revert-mode)

;; display-line-numbers.el
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(with-eval-after-load 'display-line-numbers
  (setq-default display-line-numbers-type 'relative))

;; display-fill-column-indicator
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(with-eval-after-load 'display-fill-column-indicator
  (setq-default display-fill-column-indicator-column 80))

;; elec-pair.el
(add-hook 'prog-mode-hook #'electric-pair-mode)

;; ibuffer.el
(global-set-key (kbd "C-x C-b") #'ibuffer)
(with-eval-after-load 'ibuffer
  (setq-default ibuffer-filter-group-name-face 'font-lock-doc-face))

;; dired.el
(with-eval-after-load 'dired
  (setq-default dired-dwim-target t)
  (setq dired-listing-switches "-alGhv --group-directories-first")
  (setq-default dired-recursive-copies 'always)
  (setq-default dired-kill-when-opening-new-dired-buffer t))

;; whitespace.el
(add-hook 'prog-mode-hook #'whitespace-mode)
(with-eval-after-load 'whitespace
  (setq-default whitespace-style '(trailing face)))

;; so-long.el
(add-hook 'after-init-hook #'global-so-long-mode)

;; delsel.el
(add-hook 'after-init-hook #'delete-selection-mode)

;; paren.el
(add-hook 'after-init-hook #'show-paren-mode)
(with-eval-after-load 'paren
  (setq show-paren-when-point-inside-paren t)
  (setq show-paren-when-point-in-periphery t)
  (setq show-paren-context-when-offscreen t)
  (setq show-paren-delay 0.2))

;; hl-line.el
(add-hook 'prog-mode-hook #'hl-line-mode)

;; saveplace.el
(add-hook 'after-init-hook #'save-place-mode)

;; isearch.el
(with-eval-after-load 'isearch
  (setq isearch-lazy-count t)
  (setq isearch-allow-motion t)
  (setq isearch-motion-changes-direction t))

;; minibuffer.el
(add-hook 'after-init-hook #'minibuffer-depth-indicate-mode)
(with-eval-after-load 'minibuffer
  (setq read-file-name-completion-ignore-case t)
  (setq inhibit-message-regexps '("^Saving file" "^Wrote"))
  (setq set-message-functions '(inhibit-message)))

;; winner.el
(add-hook 'after-init-hook #'winner-mode)

;; flymake.el
(add-hook 'prog-mode-hook #'flymake-mode)
(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)

;; syntax.el
(setq-default syntax-wholeline-max 500)

(provide 'init)
;;; init.el ends here
