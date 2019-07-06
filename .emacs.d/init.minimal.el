;; ==== package ===
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
(package-refresh-contents)		; comment out unless the first time
(defvar my/favorite-packages
  '(
    helm
    lua-mode
    use-package
    spacemacs-theme
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
(setq indent-tabs-mode nil)
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)
(setq linum-format "%4d  ")
(menu-bar-mode 0)


;; ==== theme ====
(load-theme 'spacemacs-dark t)


;; ==== linter ====
(global-flycheck-mode t)


;; ==== complete ====
(helm-mode t)
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
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'innamespace 0)
  (setq c-basic-offset 4
	indent-tabs-mode nil
	c-default-style "mine"))

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
  (add-hook 'rust-mode-hook #'racer-mode)
  (setq-default rust-format-on-save t)
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package racer flycheck-rust rust-mode spacemacs-theme lua-mode helm d-mode company-dcd))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
