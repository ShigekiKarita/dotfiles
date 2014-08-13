;; ======================
;; 最初に読み込んでほしいやつ
;; ======================

(setq gc-cons-threshold 268435456)      ; GCのおきる使用量
(setq make-backup-files nil)            ; バックアップを作らない
(setq auto-save-default nil)
(menu-bar-mode 0)                       ; メニューバー非表示
(tool-bar-mode 0)                       ; ツールバー非表示
(scroll-bar-mode 0)                     ; スクロールバー非表示
(setq inhibit-startup-message t)        ; 起動時の標準バッファ非表示
(xterm-mouse-mode t)                    ; 幅の調整
(windmove-default-keybindings)          ; Shiftキーでバッファ移動
(ido-mode 1)                            ; C-x f の補完
(fset 'yes-or-no-p 'y-or-n-p)           ; "yes or no"を"y or n"に
(setq-default fill-column 99999)        ; disable auto-return
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))) ;; 5 lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; minibufferでC-wで前の単語を削除
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; for shell-mode

;; shell-modeでpasswordを隠す
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; flatten mode-line
(set-face-attribute 'mode-line          nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)


;; 使ってないやつ

;; テーマ
; (load-theme 'tango t)

;; フレームを透過
;; (if window-system (set-frame-parameter nil 'alpha 100))

;; 行番号の表示
;; (setq linum-format
;;       '(lambda (line)
;;          (let ((fmt
;;                 (let ((min-w 4)
;;                       (w (length (number-to-string
;;                                   (count-lines (point-min) (point-max))))))
;;                   (concat "%"
;;                           (number-to-string (if (< min-w w) w min-w))
;;                           "d"))))
;;            (propertize (format fmt line) 'face 'linum))))
;; (global-linum-mode)

;; cursor-color
;; (set-cursor-color 'Purple)
;; buffer move with shift-arrows

