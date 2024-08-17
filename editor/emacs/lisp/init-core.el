;;; init-core.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; faces.el
(defun set-gui-font ()
  (interactive)
  (when (display-graphic-p)
    (cl-loop for font in '("JetBrainsMono Nerd Font"
                           "UbuntuMono Nerd Font"
                           "Hack Nerd Font"
                           "Monaco"
                           "Consolas")
             when (find-font (font-spec :name font))
             return (set-face-attribute 'default nil :family font :height 140))
    (cl-loop for font in '("LXGW WenKai Mono"
                           "WenQuanYi Micro Hei"
                           "PingFang TC"
                           "Microsoft Yahei"
                           "STFangsong")
             when (find-font (font-spec :name font))
             return (progn
                      (setq face-font-rescale-alist `((,font . 1.2)))
                      (set-fontset-font t '(#x4e00 . #x9fff) (font-spec :family font))))))
(add-hook 'window-setup-hook #'set-gui-font)

;; package.el
(setq package-check-signature nil)
(setq package-quickstart t)
(when (or (featurep 'esup-child)
          (daemonp)
          noninteractive)
  (package-initialize))
(setq package-archives
      '(;; ("elpa-devel" . "https://elpa.gnu.org/devel/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ;; ("org" . "https://orgmode.org/elpa/")
        ;; ("marmalade" . "http://marmalade-repo.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))
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

;; modus-themes.el
(add-hook 'after-init-hook (lambda() (load-theme 'modus-vivendi t)))

;; C source code
(setq-default tab-width 2)
(setq-default truncate-lines t)
(setq show-trailing-whitespace t)

;; simple.el
(setq-default indent-tabs-mode nil)
(add-hook 'after-init-hook #'column-number-mode)
(add-hook 'after-init-hook #'line-number-mode)
(add-hook 'after-init-hook #'size-indication-mode)

;; files.el
(add-hook 'after-init-hook #'auto-save-visited-mode)

;; autorevert.el
(add-hook 'after-init-hook #'global-auto-revert-mode)

;; display-line-numbers.el
(add-hook 'after-init-hook #'global-display-line-numbers-mode)

;; display-fill-column-iindicator.el
(add-hook 'after-init-hook #'global-display-fill-column-indicator-mode)

;; elec-pair.el
(add-hook 'after-init-hook #'electric-pair-mode)

;; flymake.el
(add-hook 'prog-mode-hook #'flymake-mode)

;; ibuffer.el
(defalias 'list-buffers 'ibuffer)

;; dired.el
(with-eval-after-load 'dired
  (setq dired-dwim-target t)
  (setq dired-listing-switches "-alh"))

;; whitespace.el
(setq whitespace-style '(trailing face))
(add-hook 'after-init-hook #'global-whitespace-mode)

;; so-long.el
(add-hook 'after-init-hook #'global-so-long-mode)

;; delsel.el
(add-hook 'after-init-hook #'delete-selection-mode)

;; paren.el
(add-hook 'after-init-hook #'show-paren-mode)

;; hl-line.el
(add-hook 'after-init-hook #'global-hl-line-mode)

;; isearch.el
(with-eval-after-load 'isearch
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "[%s/%s]"))

;; saveplace.el
(add-hook 'after-init-hook #'save-place-mode)

;; tab-line.el
(add-hook 'after-init-hook #'global-tab-line-mode)

;; treesit.el
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
        (markdown . ("https://github.com/MDeiml/tree-sitter-markdown" nil "tree-sitter-markdown/src"))
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
        (mojo . ("https://github.com/HerringtonDarkholme/tree-sitter-mojo"))))
(when (and (treesit-available-p) (file-directory-p (concat (file-name-as-directory user-emacs-directory) "tree-sitter")))
  (add-hook 'c-mode-hook #'c-ts-mode)
  (add-hook 'c++-mode-hook #'c++-ts-mode)
  (add-hook 'cmake-mode-hook #'cmake-ts-mode)
  (add-hook 'conf-toml-mode-hook #'toml-ts-mode)
  (add-hook 'css-mode-hook #'css-ts-mode)
  (add-hook 'js-mode-hook #'js-ts-mode)
  (add-hook 'js-json-mode-hook #'json-ts-mode)
  (add-hook 'python-mode-hook #'python-ts-mode)
  (add-hook 'sh-mode-hook #'bash-ts-mode)
  (add-hook 'typescript-mode-hook #'typescript-ts-mode)
  (add-hook 'rust-mode-hook #'rust-ts-mode)
  (add-hook 'java-mode-hook #'java-ts-mode)
  (add-hook 'web-mode-hook #'(lambda() (let ((file-name (buffer-file-name))) (when file-name (treesit-parser-create (pcase (file-name-extension file-name) ("vue" 'vue) ("html" 'html) ("php" 'php)))))))
  (add-hook 'markdown-mode-hook #'(lambda() (treesit-parser-create 'markdown)))
  (add-hook 'zig-mode-hook #'(lambda() (treesit-parser-create 'zig)))
  (add-hook 'mojo-mode-hook #'(lambda() (treesit-parser-create 'mojo)))
  (add-hook 'emacs-lisp-mode-hook #'(lambda() (treesit-parser-create 'elisp)))
  (add-hook 'ielm-mode-hook #'(lambda() (treesit-parser-create 'elisp)))
  (add-hook 'json-mode-hook #'(lambda() (treesit-parser-create 'json)))
  (add-hook 'go-mode-hook #'(lambda() (treesit-parser-create 'go)))
  (add-hook 'java-mode-hook #'(lambda() (treesit-parser-create 'java)))
  (add-hook 'java-ts-mode-hook #'(lambda() (treesit-parser-create 'java)))
  (add-hook 'php-mode-hook #'(lambda() (treesit-parser-create 'php)))
  (add-hook 'php-ts-mode-hook #'(lambda() (treesit-parser-create 'php)))
  (add-hook 'java-ts-mode-hook #'(lambda() (treesit-parser-create 'java)))
  (add-hook 'haskell-mode-hook #'(lambda() (treesit-parser-create 'haskell)))
  (add-hook 'kotlin-mode-hook #'(lambda() (treesit-parser-create 'kotlin))))

(provide 'init-core)
;;; init-core.el ends here
