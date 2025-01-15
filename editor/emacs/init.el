;;; init.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;;;;;;;;;;
;; CORE ;;
;;;;;;;;;;

;; faces.el
(add-hook
 'window-setup-hook
 #'(lambda()
     (cl-loop for font in '("Jetbrains Mono" "SF Mono" "Menlo" "Monaco" "Consolas")
              when (find-font (font-spec :name font))
              return (set-face-attribute 'default nil :family font :height 140))))
(add-hook 'tty-setup-hook #'xterm-mouse-mode)

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
                (horizontal-scroll-bars)))
(when (featurep 'ns)
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super))

;; startup.el
(setq auto-save-list-file-prefix nil)
(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n\n"))
(setq inhibit-startup-message t)

;; package.el
(setq package-enable-at-startup nil)
(setq package-check-signature nil)
(setq package-quickstart t)
(when (or (featurep 'esup-child) (daemonp) noninteractive)
  (package-initialize))
(setq package-archives '(;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
                         ;; ("org" . "https://orgmode.org/elpa/")
                         ;; ("marmalade" . "http://marmalade-repo.org/packages/")
                         ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ;; ("jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(defun require-package (package &optional min-version no-refresh)
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

;; flymake.el
(add-hook 'prog-mode-hook #'flymake-mode)
(global-set-key (kbd "M-n") #'flymake-goto-next-error)
(global-set-key (kbd "M-p") #'flymake-goto-prev-error)

;; font-lock.el
(font-lock-add-keywords 'emacs-lisp-mode '(("\\<require-package\\>" . font-lock-keyword-face)))

;;;;;;;;;;;;;;;;;;;;;;;;;
;; THIRD-PARTY PACKAGE ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

;; evil
(require-package 'evil)
(add-hook 'after-init-hook
          #'(lambda()
              (setq evil-want-integration t)
              (setq evil-want-keybinding nil)
              (evil-mode +1)))
(with-eval-after-load 'evil
  (setq evil-normal-state-cursor 'box)
  (setq evil-emacs-state-cursor  'bar)
  (setq evil-insert-state-cursor 'bar)
  (setq evil-visual-state-cursor 'hollow)
  (setq evil-replace-state-cursor 'hollow))
(defun modeline-color-border (&rest _)
  "A tweak for change modeline border color with evil mode."
  (unless (minibufferp)
    (when (eq (window-buffer (selected-window)) (current-buffer))
      (let* ((color
              (cond
               ((evil-normal-state-p) "#006fa0")
               ((evil-emacs-state-p) "#444488")
               ((evil-insert-state-p) "#ff0000")
               ((evil-motion-state-p) "#ffffff")
               ((evil-visual-state-p) "#e80074")
               ((evil-operator-state-p) "#ffffff")
               ((evil-replace-state-p) "#e80074")
               (t "#ffffff"))))
        (set-face-attribute 'mode-line nil :box `(:line-width (3 . 3) :color ,color))))))
(add-hook 'evil-emacs-state-entry-hook #'modeline-color-border)
(add-hook 'evil-insert-state-entry-hook #'modeline-color-border)
(add-hook 'evil-motion-state-entry-hook #'modeline-color-border)
(add-hook 'evil-normal-state-entry-hook #'modeline-color-border)
(add-hook 'evil-visual-state-entry-hook #'modeline-color-border)
(add-hook 'evil-replace-state-entry-hook #'modeline-color-border)
(add-hook 'evil-operator-state-entry-hook #'modeline-color-border)
(add-hook 'window-selection-change-functions #'modeline-color-border)

;; evil-escape
(require-package 'evil-escape)
(add-hook 'evil-mode-hook #'evil-escape-mode)
(with-eval-after-load 'evil-escape
  (setq-default evil-escape-delay 0.2)
  (setq evil-escape-excluded-major-modes '(neotree-mode treemacs-mode vterm-mode))
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

;; evil-visualstar
(require-package 'evil-visualstar)
(add-hook 'evil-mode-hook #'global-evil-visualstar-mode)

;; rainbow-delimiters
(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; symbol-overlay
(require-package 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)

;; colorful-mode
(require-package 'colorful-mode)
(add-hook 'prog-mode-hook #'global-colorful-mode)

;; git-gutter
(require-package 'git-gutter)
(add-hook 'prog-mode-hook #'git-gutter-mode)

;; indent-bars
(require-package 'indent-bars)
(add-hook 'prog-mode-hook #'indent-bars-mode)
(with-eval-after-load 'indent-bars
  (setq indent-bars-color '(highlight :face-bg t :blend 0.75))
  (setq indent-bars-no-descend-string nil)
  (setq indent-bars-no-descend-lists nil)
  (setq indent-bars-display-on-blank-lines nil)
  (setq indent-bars-prefer-character t))

;; hl-todo
(require-package 'hl-todo)
(add-hook 'prog-mode-hook #'hl-todo-mode)
(with-eval-after-load 'hl-todo
  (setq hl-todo-highlight-punctuation ":")
  (setq hl-todo-keyword-faces
        '(("TODO" warning bold)
          ("FIXME" error bold)
          ("REVIEW" font-lock-keyword-face bold)
          ("HACK" font-lock-constant-face bold)
          ("DEPRECATED" font-lock-doc-face bold)
          ("NOTE" success bold)
          ("BUG" error bold)
          ("XXX" font-lock-constant-face bold))))

;; xclip
(require-package 'xclip)
(add-hook 'after-init-hook #'xclip-mode)

;; diredfl
(require-package 'diredfl)
(add-hook 'dired-mode-hook #'diredfl-mode)

;; nerd-icons-ibuffer
(require-package 'nerd-icons-ibuffer)
(add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)

;; nerd-icons-dired
(require-package 'nerd-icons-dired)
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)

;; vertico
(require-package 'vertico)
(add-hook 'after-init-hook #'vertico-mode)
(with-eval-after-load 'vertico
  (setq vertico-scroll-margin 0)
  (setq vertico-count 15)
  (setq vertico-resize nil)
  (setq vertico-cycle t)
  (define-key vertico-map (kbd "RET") #'vertico-directory-enter)
  (define-key vertico-map (kbd "DEL") #'vertico-directory-delete-char))

;; nerd-icons-completion
(require-package 'nerd-icons-completion)
(add-hook 'minibuffer-mode-hook #'nerd-icons-completion-mode)

;; marginalia
(require-package 'marginalia)
(add-hook 'after-init-hook #'marginalia-mode)

;; orderless
(require-package 'orderless)
(setq completion-styles '(orderless basic))
(setq completion-category-overrides '((file (styles basic partial-completion))))

;; consult
(require-package 'consult)
(global-set-key [remap isearch-forward] #'consult-line)
(global-set-key [remap switch-to-buffer] #'consult-buffer)
(global-set-key [remap goto-line] #'consult-goto-line)
(global-set-key [remap load-theme] #'consult-theme)
(global-set-key [remap switch-to-buffer-other-frame] #'consult-buffer-other-frame)
(global-set-key [remap switch-to-buffer-other-window] #'consult-buffer-other-window)
(global-set-key [remap yank-pop] #'consult-yank-pop)
(global-set-key [remap load-theme] #'consult-theme)
(global-set-key (kbd "M-g f") #'consult-flymake)
(global-set-key (kbd "M-g o") #'consult-outline)
(global-set-key (kbd "M-g r") #'consult-grep)
(global-set-key (kbd "C-c C-r") #'consult-ripgrep)
(define-key minibuffer-local-map (kbd "M-s") #'consult-history)
(with-eval-after-load 'consult
  (setq consult-line-numbers-widen t))

;; consult-yasnippet
(require-package 'consult-yasnippet)
(global-set-key (kbd "M-y") 'consult-yasnippet)

;; embark & embark-consult
(require-package 'embark)
(require-package 'embark-consult)
(add-hook 'embark-collect-mode #'consult-preview-at-point-mode)
(define-key minibuffer-mode-map (kbd "C-c C-o") #'embark-export)

;; yasnippet & yasnippet-snippets
(require-package 'yasnippet)
(require-package 'yasnippet-snippets)
(add-hook 'prog-mode-hook #'yas-global-mode)

;; corfu
(require-package 'corfu)
(add-hook 'prog-mode-hook #'global-corfu-mode)
(add-hook 'global-corfu-mode-hook #'corfu-popupinfo-mode)
(with-eval-after-load 'corfu
  (setq corfu-cycle t)
  (setq corfu-auto t)
  (setq corfu-auto-prefix 1)
  (setq corfu-auto-delay 0.1)
  (setq corfu-preselect 'prompt)
  (setq corfu-count 16)
  (setq corfu-max-width 120)
  (setq corfu-on-exact-match nil)
  (setq global-corfu-modes '((not erc-mode circe-mode help-mode gud-mode vterm-mode) t))
  (setq corfu-popupinfo-delay '(0.5 . 1.0)))

;; corfu-terminal
(require-package 'corfu-terminal)
(when (not (display-graphic-p))
  (add-hook 'global-corfu-mode-hook #'corfu-terminal-mode))

;; nerd-icons-corfu
(require-package 'nerd-icons-corfu)
(with-eval-after-load 'corfu
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; cape
(require-package 'cape)
(add-hook 'completion-at-point-functions #'cape-dabbrev)
(add-hook 'completion-at-point-functions #'cape-file)
(add-hook 'completion-at-point-functions #'cape-elisp-block)

;; wgrep
(require-package 'wgrep)

;; gcmh
(require-package 'gcmh)
(add-hook 'after-init-hook #'gcmh-mode)

;; vundo
(require-package 'vundo)

;; quickrun
(require-package 'quickrun)

;; olivetti
(require-package 'olivetti)

;; breadcrumb
(require-package 'breadcrumb)
(add-hook 'prog-mode-hook #'breadcrumb-mode)

(provide 'init)
;;; init.el ends here
