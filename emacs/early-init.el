;;; early-init.el --- -*- lexical-binding: t; coding: utf-8; -*-
;;; Commentary:
;;; Code:

;; Font Setup
(add-hook 'window-setup-hook
          #'(lambda ()
              (require 'cl-lib)
              (cl-loop for font in '("JetBrainsMono Nerd Font" "VictorMono Nerd Font" "Monaco" "Consolas")
                       when (find-font (font-spec :name font))
                       return (set-face-attribute 'default nil :font font :weight 'normal :height 130))
              (cl-loop for font in '("SF Pro" "Microsoft Yahei UI" "Microsoft Yahei")
                       when (find-font (font-spec :name font))
                       return (set-fontset-font t '(#x4e00 . #x9fff) (font-spec :name font :weight 'normal)))))

;; Package initialize occurs automatically, before `user-init-file' is loaded, but after `early-init-file'.
;; We handle package initialization, so we must prevent Emacs from doing it early!
(when (or (featurep 'esup-child)
          (daemonp)
          noninteractive)
  (setq package-enable-at-startup nil))

;; Adjust gc threshold
;; @see https://www.reddit.com/r/emacs/comments/ofhket/further_boost_start_up_time_with_a_simple_tweak/
(setq gc-cons-percentage 0.6)
(setq gc-cons-threshold most-positive-fixnum)

;; Initial major mode for startup faster
(setq initial-major-mode 'fundamental-mode)

;; Disable autosave and backup
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq make-backup-files nil)

;; Inhibit resizing frame and startup message
(setq inhibit-startup-message t)
(setq frame-inhibit-implied-resize t)

;; Prevent stuck when open large file
(setq-default bidi-display-reordering nil)
(setq bidi-inhibit-bpa t)
(setq long-line-threshold 500)
(setq large-hscroll-threshold 500)
(setq syntax-wholeline-max 500)
(setq-default bidi-paragraph-direction 'left-to-right)

;; Reduce rendering/line scan work for Emacs by not rendering cursors or regions in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; More performant rapid scrolling over unfontified regions. May cause brief
;; spells of inaccurate syntax highlighting right after scrolling, which should
;; quickly self-correct.
(setq fast-but-imprecise-scrolling t)

;; Font compacting can be terribly expensive, especially for rendering icon
;; fonts on Windows. Whether disabling it has a notable affect on Linux and Mac
;; hasn't been determined, but do it anyway, just in case. This increases memory
;; usage, however!
(setq inhibit-compacting-font-caches t)

;; Increase how much is read from processes in a single chunk (default is 4kb).
;; This is further increased elsewhere, where needed (like our LSP module).
(setq read-process-output-max (* 64 1024))

;; Introduced in Emacs HEAD (b2f8c9f), this inhibits fontification while
;; receiving input, which should help a little with scrolling performance.
(setq redisplay-skip-fontification-on-input t)

;; Faster to disable these here before they've been initialized
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

;; Contrary to what many Emacs users have in their configs, you don't need more
;; than this to make UTF-8 the default coding system:
(set-language-environment "UTF-8")
(setq default-input-method nil)

;; Disable native compilation
(if (and (featurep 'native-compile) (fboundp 'native-comp-available-p) (native-comp-available-p))
    (setq native-comp-jit-compilation nil)
  (setq package-native-compile nil)
  (setq features (delq 'native-compile features)))

;; short answers
(setq use-short-answers t)

;; custom files
(setq custom-file (locate-user-emacs-file "custom.el"))
;; (when (file-exists-p custom-file) (load custom-file))

(provide 'early-init)
;;; early-init.el ends here
