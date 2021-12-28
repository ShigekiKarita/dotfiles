;; ==== package ===
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
;; (package-refresh-contents)  ; do this for the first time
(defvar my/favorite-packages
  '(
    helm
    lua-mode
    use-package
    spacemacs-theme
    markdown-mode
    google-c-style
    ;; rust
    racer
    flycheck-rust
    ;; dlang
    d-mode
    company
    company-dcd
    flycheck-dmd-dub
    ))
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))


;; ==== general ====
(defalias 'yes-or-no-p 'y-or-n-p)
(prefer-coding-system 'utf-8-unix)
(setq coding-system-for-read 'utf-8-unix)
(setq coding-system-for-write 'utf-8-unix)
(global-linum-mode 1)
(show-paren-mode t)
;; (w32-select-font) ; list fonts for windows
(set-face-attribute 'default nil :family "Ricty Diminished Discord for Po-30" :height 130)
(setq ring-bell-function 'ignore)
(setq-default indent-tabs-mode nil)
;; (set-face-attribute 'mode-line nil :box nil)
;; (set-face-attribute 'mode-line-inactive nil :box nil)
(setq linum-format "%4d  ")
(menu-bar-mode 0)
(windmove-default-keybindings)
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <right>") 'windmove-right)

;; scroll line-by-line
(setq scroll-step            1
      scroll-conservatively  10000)

;; whitespace mode
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         spaces         ; スペース
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         lines-tail))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角　のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))
;; lint 80 col
(setq whitespace-line-column 80)
(global-whitespace-mode 1)
(column-number-mode)

;; ==== theme ====
;; (load-theme 'spacemacs-dark t)


;; ==== linter ====
(global-flycheck-mode t)


;; ==== complete ====
(recentf-mode t)
(helm-mode t)
;; (global-set-key (kbd "C-f") 'helm-recentf)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-company-mode t)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 2)
(setq company-selection-wrap-around t)


;; ==== C++ ====
(c-add-style
 "mine"
 '("java"
   (c-basic-offset . 4)
   (c-hanging-braces-alist
    ((substatement-open)
     (block-close . c-snug-do-while)
     (extern-lang-open after)
     (inexpr-class-open after)
     (inexpr-class-close before)))
   (c-offsets-alist
    (substatement-open . 0))
   ))
(defun my/c++-mode-init ()
  (subword-mode)
  (google-set-c-style)
  (google-make-newline-indent)
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'innamespace 0)
  (setq c-basic-offset 4))
	;; indent-tabs-mode nil
	;; c-default-style "mine"))
(add-hook 'c-mode-hook 'my/c++-mode-init)
(add-hook 'c++-mode-hook 'my/c++-mode-init)



;; ==== lua ====
;; (setq lua-default-application "luajit")


;; ==== gauche ====
(use-package scheme
  :config
  (setq process-coding-system-alist
	(cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
  (setq scheme-program-name "gosh -i")
  (autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
  (autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
  (defun scheme-other-window ()
    "Run Gauche on other window"
    (interactive)
    (split-window-horizontally (/ (frame-width) 2))
    (let ((buf-name (buffer-name (current-buffer))))
      (scheme-mode)
      (switch-to-buffer-other-window
       (get-buffer-create "*scheme*"))
      (run-scheme scheme-program-name)
      (switch-to-buffer-other-window
       (get-buffer-create buf-name))))
  (define-key global-map "\C-cG" 'scheme-other-window))


;; ==== dlang ====
(use-package d-mode
  :config
  (add-hook 'd-mode-hook 'flycheck-dmd-dub-set-variables)
  (add-hook 'd-mode-hook 'company-dcd-mode)
  (add-hook 'd-mode-hook 'my/c++-mode-init))


;; === rust ===
(use-package rust-mode

  :init (setq racer-rust-src-path
              (concat (string-trim
                       (shell-command-to-string "rustc --print sysroot"))
                      "/lib/rustlib/src/rust/src"))

  :config
  (setq-default rust-format-on-save t)
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; zig-mode
(use-package eglot
  :ensure t)
(use-package zig-mode
  :ensure t
  :config
  (add-hook 'zig-mode-hook 'eglot-ensure)
  (add-to-list 'eglot-server-programs
               `(zig-mode . ("zls"))))

;; common lisp
(use-package slime
  :ensure slime-company
  :custom
  inferior-lisp-program "sbcl"
  :config (slime-setup '(slime-repl slime-fancy slime-banner slime-company)))
(use-package slime-company
  :ensure t
  :after (slime company)
  :custom
  slime-company-completion 'fuzzy
  slime-company-after-completion 'slime-company-just-one-space)


;; etc
(use-package python
  :custom
  tab-width 2)

(use-package yaml-mode
  :ensure t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(package-selected-packages
   (quote
    (nhexl-mode slime-company slime protobuf-mode yaml-mode eglot zig-mode markdown-mode use-package racer flycheck-rust rust-mode spacemacs-theme lua-mode helm d-mode company-dcd))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
