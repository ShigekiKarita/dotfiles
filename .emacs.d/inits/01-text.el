;; ==========
;; 入力支援関係
;; ==========

(global-set-key "\C-m" 'newline-and-indent) ; 改行時にインテンド
(show-paren-mode t)                         ; 対応する括弧の強調表示
(setq-default c-basic-offset 4              ; 基本インデント量4
              tab-width 4                   ; タブ幅4
              indent-tabs-mode nil)         ; タブでなくスペース



;; 括弧の補完
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)



;; Font設定
(when window-system
  ;; (progn
  ;;   (setq default-frame-alist
  ;;         (append '((width . 108)
  ;;                   (height . 32)
  ;;                   (font . "Menlo"))
  ;;                 default-frame-alist)))
  (set-face-attribute 'default nil
                       :family "Menlo"
                       :height 140)
  (set-fontset-font
   nil 'japanese-jisx0208
   (font-spec :family "Hiragino Kaku Gothic ProN"))
  (setq face-font-rescale-alist
        '((".*Hiragino_Mincho_pro.*" . 2.0))))
