

;; Emacs24標準のパッケージマネージャ
;; 必要なパッケージをインストール
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (p '(; paredit
             tabbar
             powerline
             rainbow-delimiters
             auto-complete
             yasnippet
             anything
             flycheck
             flycheck-pos-tip
             dash
             s
             f
             anzu
             smart-compile
             ;; clojure
             clojure-mode
             cider
             ac-nrepl
             clojure-cheatsheet
             clojure-snippets
             ;; haskell
             haskell-mode
             ;; scheme

             ;; Common Lisp (slimeは本家から直で)
             popwin
             ac-slime
             ;; D
             d-mode
             flycheck-d-unittest
             ;; ruby
             ruby-electric
             ruby-block
             motion-mode
             rubocop
             ;; js
             js2-mode
             web-mode
             ;; OCaml
             tuareg
             utop
             merlin
             ;; perl
             cperl-mode
             perl-completion
             ;; others
             processing-mode
             exec-path-from-shell
	     ))
  (when (not (package-installed-p p))
    (package-install p)))



;; smex : M-xの補完
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; anything
; (require 'anything-startup)
(global-set-key (kbd "C-x b") 'anything-for-files)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "C-x M-x") 'anything-M-x)
(setq recentf-max-menu-items 10)        ;; 表示するファイルの数
(setq recentf-max-saved-items 30)       ;; 保存するファイルの数
(setq kill-ring-max 100)                ;; kill-ring で保存される最大値

;; flycheck
; (require 'flycheck-color-mode-line)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))


;; 括弧の色分け
; (require 'rainbow-delimiters)
(global-rainbow-delimiters-mode t)
;;(custom-set-faces '(rainbow-delimiters-depth-1-face ((t (:foreground "#7f8c8d")))))
(custom-set-faces
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#AAAAAA"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#666666"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#B96D49"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#9E3174"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#4553FF"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#4F9C9D"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#9B27B2"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#2C5513"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#77481C"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "red"))))
 '(show-paren-match ((((class color) (background light)) (:background "#5DDADB")))))


;; auto-complete
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(setq ac-use-menu-map t) ; auto-completeのポップアップメニューでC-n/C-pが使えるようにする


;; anzu 検索・置換ツール
;; (global-anzu-mode +1)
;; (set-face-attribute 'anzu-mode-line nil
;;                     :foreground "yellow" :weight 'bold)
;; (custom-set-variables '(anzu-mode-lighter "")
;;                       '(anzu-deactivate-region t)
;;                       '(anzu-search-threshold 1000)
;;                       '(anzu-use-mimego t)
;;                       '(anzu-replace-to-string-separator " => "))

;; ;; tabbar.el
;; (require 'tabbar)
;; (tabbar-mode 0)
;; ;; グループ化しない
;; (setq tabbar-buffer-groups-function nil)
;; ;; 左に表示されるボタンを無効化
;; (dolist (btn '(tabbar-buffer-home-button
;; 	       tabbar-scroll-left-button
;; 	       tabbar-scroll-right-button))
;;   (set btn (cons (cons "" nil)
;; 		 (cons "" nil))))
;; ;; タブ同士の間隔
;; (setq tabbar-separator '(0.8))
;; ;; 外観変更
;; (set-face-attribute
;;  'tabbar-default nil
;;  :family (face-attribute 'default :family)
;;  :background (face-attribute 'mode-line-inactive :background)
;;  :height 0.9)
;; (set-face-attribute
;;  'tabbar-unselected nil
;;  :background (face-attribute 'mode-line-inactive :background)
;;  :foreground (face-attribute 'mode-line-inactive :foreground)
;;  :box nil)
;; (set-face-attribute
;;  'tabbar-selected nil
;;  :background (face-attribute 'mode-line :background)
;;  :foreground (face-attribute 'mode-line :foreground)
;;  :box nil)


(exec-path-from-shell-initialize)


