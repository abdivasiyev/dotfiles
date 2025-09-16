(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

(defvar bootstrap-version)
(let ((bootstrap-file
    (expand-file-name
      "straight/repos/straight.el/bootstrap.el"
      (or (bound-and-true-p straight-base-dir)
        user-emacs-directory)))
    (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq use-package-always-defer t)

(use-package emacs
  :init
  (setq initial-scratch-message nil)
  (defun display-startup-echo-area-message ()
    (message "")))

(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p))

(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix)))

(use-package emacs
  :init
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (global-auto-revert-mode 1))

(use-package emacs
  :init
	(when (eq system-type 'darwin)
		(setq mac-command-modifier 'super)
		(setq mac-option-modifier 'meta)
		(setq mac-control-modifier 'control)))

(use-package evil
  :demand ; No lazy loading
  :config
  (evil-mode 1))

(use-package emacs
  :init
  (set-face-attribute 'default nil
    :font "JetBrains Mono"
    :height 160))

;; Gruvbox theme
(use-package gruvbox-theme
  :demand
  :config
  (load-theme 'gruvbox-dark-medium t))

(use-package emacs
  :init
  (defun ab/enable-line-numbers ()
    "Enable relative line numbers"
    (interactive)
    (display-line-numbers-mode)
    (setq display-line-numbers 'relative))
  (add-hook 'prog-mode-hook #'ab/enable-line-numbers))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons)

(use-package which-key
  :demand
  :init
  (setq which-key-idle-delay 0.5) ; Open after .5s instead of 1s
  :config
  (which-key-mode))

(use-package general
  :demand
  :config
  (general-evil-setup)

  (general-create-definer leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (leader-keys
    "x" '(execute-extended-command :which-key "execute command")
    "r" '(restart-emacs :which-key "restart emacs")
    "i" '((lambda () (interactive) (find-file user-init-file)) :which-key "open init file")

    ;; Buffer
    "b" '(:ignore t :which-key "buffer")
    ;; Don't show an error because SPC b ESC is undefined, just abort
    "b <escape>" '(keyboard-escape-quit :which-key t)
    "bd"  'kill-current-buffer
  ))

(use-package eg
  :ensure t)

(use-package vertico
  :ensure t
  :init
  (vertico-mode +1))

(use-package projectile
  :demand
  :init
  (setq projectile-project-search-path '("~/Development/"))
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  (projectile-mode +1))

(use-package ivy
  :config
  (ivy-mode))

(use-package magit
  :general
  (leader-keys
    "g" '(:ignore t :which-key "git")
    "g <escape>" '(keyboard-escape-quit :which-key t)
    "g g" '(magit-status :which-key "status")
    "g l" '(magit-log :which-key "log"))
  (general-nmap
    "<escape>" #'transient-quit-one))

(use-package evil-collection
  :after evil
  :demand
  :config
  (evil-collection-init))

(use-package diff-hl
  :demand t
  :init
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  :config
  (global-diff-hl-mode))

(use-package vterm)

(use-package vterm-toggle
  :general
  (leader-keys
    "t t" '(vterm-toggle :which-key "terminal")))

(use-package evil-nerd-commenter
  :general
  (general-nvmap
    "gc" 'evilnc-comment-operator))

(use-package gcmh
  :demand
  :config
  (gcmh-mode 1))

(use-package emacs
  :init
	(global-set-key (kbd "<escape>") 'keyboard-escape-quit))

(use-package emacs
  :init
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . light))
  (setq ns-use-proxy-icon  nil)
  (setq frame-title-format nil))

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-initialize))

(use-package emacs
  :init
  (setq-default fill-column 110)
  (set-face-attribute 'fill-column-indicator nil
                      :foreground "#717C7C" ; katana-gray
                      :background "transparent")
  (global-display-fill-column-indicator-mode 1))

(use-package emacs
  :config
  (setq backup-directory-alist `(("." . "~/.local/emacs/.saves"))))

(use-package company-mode
  :init
  (global-company-mode))

(use-package emacs
  :hook (rust-mode . eglot-ensure)
  :hook (go-mode . eglot-ensure)
  :hook (haskell-mode . eglot-ensure)
  :hook (dockerfile-mode . eglot-ensure)
  :hook (docker-compose-mode . eglot-ensure)
  :config
    ;; lsp configurations
  (setq eglot-workspace-configuration
      '((:gopls .
                ((staticcheck . t)
                 (matcher . "CaseSensitive")
                 (usePlaceholders . t)
                 (vulncheck . "Imports")
                 (hints .
                        ((assignVariableTypes . t)
                         (compositeLiteralFields . t)
                         (compositeLiteralTypes . t)
                         (constantValues . t)
                         (functionTypeParameters . t)
                         (ignoredError . t)
                         (parameterNames . t)
                         (rangeVariableTypes . t)))))))

  :general
  (leader-keys
    "l" '(:ignore t :which-key "lsp")
    "l <escape>" '(keyboard-escape-quit :which-key t)
    "l r" '(eglot-rename :which-key "rename")
    "l i" '(eglot-find-implementation :which-key "find implementation")
    "l a" '(eglot-code-actions :which-key "code actions")))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t))
(use-package rust-mode
  :hook ((before-save . eglot-format-buffer))
  :hook ((before-save . organize-imports))
  :general
  (leader-keys
    "m" '(:ignore t :which-key "mode")
    "m <escape>" '(keyboard-escape-quit :which-key t)
    "m b" '(rust-compile :which-key "build")
    "m r" '(rust-run :which-key "run")
    "m t" '(rust-test :which-key "test")
    "m k" '(rust-check :which-key "check")
    "m c" '(rust-run-clippy :which-key "clippy")))

(defun organize-imports ()
  (call-interactively 'eglot-code-action-organize-imports))

(use-package go-mode
  :hook ((before-save . eglot-format-buffer))
  :hook ((before-save . organize-imports)))

(use-package gotest
  :general
  (leader-keys
    "m" '(:ignore t :which-key "mode")
    "m <escape>" '(keyboard-escape-quit :which-key t)
    "m t" '(go-test-current-project :which-key "test")
    "m c" '(go-test-current-coverage :which-key "coverage")
    "m b" '(go-test-current-benchmark :which-key "benchmark")
    "m r" '(go-run :which-key "run")))
(use-package yaml-mode)
(use-package haskell-mode
  :hook ((before-save . eglot-format-buffer))
  :hook ((before-save . organize-imports)))

(use-package json-mode)
(use-package dockerfile-mode)
(use-package docker-compose-mode)

(use-package rg
  :general
  (leader-keys
    "f" '(rg-menu :which-key "find")))

(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :config
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-mode-line-height 10)
  (setq dirvish-attributes
        '(nerd-icons file-time file-size collapse subtree-state vc-state git-msg))
  (setq dirvish-subtree-state-style 'nerd)
  (setq delete-by-moving-to-trash t)
  (setq dirvish-path-separators (list
                                 (format "  %s " (nerd-icons-codicon "nf-cod-home"))
                                 (format "  %s " (nerd-icons-codicon "nf-cod-root_folder"))
                                 (format " %s " (nerd-icons-faicon "nf-fa-angle_right"))))
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  (dirvish-peek-mode) ; Preview files in minibuffer
  (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
)

(use-package telega
  :init
  (add-hook 'telega-load-hook 'telega-notifications-mode)
  (add-hook 'telega-load-hook 'telega-mode-line-mode)
  (add-hook 'telega-load-hook 'telega-autoplay-mode)
  (define-key global-map (kbd "C-c t") telega-prefix-map)
  :load-path  "~/telega.el"
  :commands (telega)
  :config
  ;; telega configurations
  (setq telega-server-libs-prefix "/opt/homebrew")
  (setq telega-accounts (list
                         (list "work" 'telega-database-dir telega-database-dir)
                         (list "personal" 'telega-database-dir
                               (expand-file-name "personal" telega-database-dir))
                         (list "community" 'telega-database-dir
                               (expand-file-name "community" telega-database-dir))))
  :defer t)

(use-package smartparens
  :ensure smartparens
  :hook (prog-mode text-mode rust-mode go-mode yaml-mode))

(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  :config
  (dashboard-setup-startup-hook))
