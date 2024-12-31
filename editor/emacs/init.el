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
;; This is a single-file Emacs configuration, aiming for minimal setup and
;; making use of built-in features as much as possible.

;;; Code:

;;; BUILT-IN

;; faces.el
(add-hook
 'window-setup-hook
 #'(lambda()
     (cl-loop for font in '("Jetbrains Mono" "SF Mono" "Monaco" "Menlo" "Consolas")
              when (find-font (font-spec :name font))
              return (set-face-attribute 'default nil :family font :height 130))))

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
(setq initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n\n"))
(setq inhibit-startup-message t)

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
(setq-default package-archives '(;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
                                 ;; ("org" . "https://orgmode.org/elpa/")
                                 ;; ("marmalade" . "http://marmalade-repo.org/packages/")
                                 ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
                                 ;; ("jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/")
                                 ("gnu" . "https://elpa.gnu.org/packages/")
                                 ("melpa" . "https://melpa.org/packages/")
                                 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(defun require-package(package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE with MIN-VERSION.
If NO-REFRESH is nil, `package-refresh-contents' is called."
  (unless (featurep 'package)
    (condition-case nil
        (require 'package)
      (error nil)))
  (unless (package-installed-p package min-version)
    (unless (or (assoc package package-archive-contents) no-refresh)
      (message "Missing package: %s" package)
      (package-refresh-contents))
    (package-install package)))

;; modus-themes.el
(add-hook 'after-init-hook #'(lambda() (load-theme 'modus-vivendi t)))

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

;;; THIRD-PARTY PACKAGES

;; evil
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(require-package 'evil)
(add-hook 'after-init-hook #'evil-mode)

;; evil-escape
(require-package 'evil-escape)
(add-hook 'evil-mode-hook #'evil-escape-mode)
(with-eval-after-load 'evil-escape
  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "jk"))

;; evil-collection
(require-package 'evil-collection)
(run-with-idle-timer 2 nil #'evil-collection-init)

;; evil-matchit
(require-package 'evil-matchit)
(add-hook 'evil-mode-hook #'global-evil-matchit-mode)

;; evil-nerd-commenter
(require-package 'evil-nerd-commenter)
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map "gcc" #'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map "gc" #'evilnc-comment-or-uncomment-lines))

;; evil-goggles
(require-package 'evil-goggles)
(add-hook 'evil-mode-hook #'evil-goggles-mode)
(with-eval-after-load 'evil-goggles
  (setq evil-goggles-duration 2.500))

;; rainbow-delimiters
(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; symbols-overlay
(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)

;; xclip
(require-package 'xclip)
(add-hook 'after-init-hook #'xclip-mode)

;; company
(require-package 'company)
(add-hook 'prog-mode-hook #'company-mode)
(with-eval-after-load 'company
  (setq company-idle-delay 0.1)
  (setq company-global-modes '(not ehsell))
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-annotation-padding 1)
  (setq company-tooltip-limit 10)
  (setq company-tooltip-offset-display 'scollbar)
  (setq company-format-margin-function #'company-text-icons-margin)
  (setq company-text-icons-add-background t)
  (setq company-minimum-prefix-length 1))

;; company-quickhelp
(require-package 'company-quickhelp)
(when (display-graphic-p)
  (add-hook 'company-mode-hook #'company-quickhelp-mode))

;; diredfl
(require-package 'diredfl)
(add-hook 'dired-mode-hook #'diredfl-mode)

;; colorful-mode
(require-package 'colorful-mode)
(add-hook 'prog-mode-hook #'global-colorful-mode)

;; nerd-icons-ibuffer
(require-package 'nerd-icons-ibuffer)
(add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)

;; nerd-icons-dired
(require-package 'nerd-icons-dired)
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

;; mode-line-bell
(require-package 'mode-line-bell)
(run-with-idle-timer 2 nil #'mode-line-bell-mode)

;; ivy
(require-package 'ivy)
(add-hook 'after-init-hook #'ivy-mode)
(with-eval-after-load 'ivy
  (setq ivy-use-virutal-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 10)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "[%d/%d]")
  (setq ivy-re-builders-alist `((t . ivy--regex-ignore-order))))

;; ivy-rich
(require-package 'ivy-rich)
(add-hook 'ivy-mode-hook #'ivy-rich-mode)

;; nerd-icons-ivy-rich
(require-package 'nerd-icons-ivy-rich)
(add-hook 'ivy-mode-hook #'nerd-icons-ivy-rich-mode)

;; counsel
(require-package 'counsel)
(add-hook 'ivy-mode-hook #'counsel-mode)

;; swiper
(require-package 'swiper)
(global-set-key (kbd "C-s") 'swiper-isearch-backward)

;; wgrep
(require-package 'wgrep)

;; amx
(require-package 'amx)

;; avy
(require-package 'avy)
(global-set-key (kbd "M-g l") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-0)
(global-set-key (kbd "M-g t") 'avy-goto-char-timer)

;; flycheck
(require-package 'flycheck)
(add-hook 'prog-mode-hook #'global-flycheck-mode)
(global-set-key (kbd "M-n") 'flycheck-next-error)
(global-set-key (kbd "M-p") 'flycheck-previous-error)

;; gcmh
(require-package 'gcmh)
(add-hook 'after-init-hook #'gcmh-mode)

;; helpful
(require-package 'helpful)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)
(global-set-key (kbd "C-h f") #'helpful-callable)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)

;; ace-window
(require-package 'ace-window)
(global-set-key [remap other-window] 'ace-window)
(with-eval-after-load 'ace-window
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-background nil)
  (setq aw-char-position 'top-left))

;; winum
(require-package 'winum)
(run-with-idle-timer 2 nil #'winum-mode)
(with-eval-after-load 'winum
  (setq winum-format "[%s]")
  (setq winum-mode-line-position 0)
  (set-face-attribute 'winum-face nil :foreground "DeepPink" :underline "DeepPink" :weight 'bold))

;; dired-sidebar
(require-package 'dired-sidebar)
(global-set-key [f1] #'dired-sidebar-toggle-sidebar)
(with-eval-after-load 'dired-sidebar
  (setq dired-sidebar-theme 'nerd-icons))

;; magit
(require-package 'magit)

;; esup
(require-package 'esup)

;; csv-mode
(require-package 'csv-mode)

;; json-mode
(require-package 'json-mode)

;; toml-mode
(require-package 'toml-mode)

(provide 'init)
;;; init.el ends here
