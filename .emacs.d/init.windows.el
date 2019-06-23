(require 'package)

;; MELPA
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Org
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(defvar my/favorite-packages
  '(
    helm
    lua-mode
    flycheck-d-unittest
    d-mode
    company
    ;; company-dcd
    ))

;; my/favorite-packages
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))

;; emacs default
(defalias 'yes-or-no-p 'y-or-n-p)
(prefer-coding-system 'utf-8-unix)
(setq coding-system-for-read 'utf-8-unix)
(setq coding-system-for-write 'utf-8-unix)
(global-linum-mode 1)
(show-paren-mode t)
;; (w32-select-font)
(set-face-attribute 'default nil :family "Ricty Diminished Discord for Po-30" :height 130)


(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

;; lua
;; (setq lua-default-application "luajit")


;; gauche
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

(define-key global-map
    "\C-cG" 'scheme-other-window)

;; d-mode
(add-hook 'd-mode-hook #'flycheck-mode)
(setup-flycheck-d-unittest)


;; helm
(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
;; misc
;; (global-flycheck-mode t)

(global-company-mode t)
(setq company-idle-delay 0) ; デフォル5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

(setq ring-bell-function 'ignore)
(setq indent-tabs-mode nil)

;; dlang


;; (add-hook 'd-mode-hook 'company-dcd-mode)
;; (setq company-dcd-client-execulable (concat (getenv "HOME") "\\tool\\DCD\\bin\\dcd-client.exe"))
;; (setq company-dcd-server-execulable (concat (getenv "HOME") "\\tool\\DCD\\bin\\dcd-server.exe"))

(add-hook 'd-mode-hook
	  '(lambda()
	     ;; (c-set-style "bsd")
	     (setq c-default-style "stroustrop"
		   c-basic-offset 4
		   indent-tabs-mode nil)
	     (c-set-offset 'innamespace 0)
	     ;; namespace {}の中はインデントしない
	     (c-set-offset 'arglist-close 0)
	     ;; 関数の引数リストの閉じ括弧はインデントしない
	     ))
(setq c-basic-offset 4)

(setq linum-format "%4d  ")
