;; ===========
;; Common Lisp
;; ===========

;; Clozure CLをデフォルトのCommon Lisp処理系に設定
(setq inferior-lisp-program "/usr/local/bin/ccl")

;; SLIME周り
;; $ wget http://common-lisp.net/project/slime/snapshots/slime-current.tgz
;; $ tar xvzf slime-current.tgz
;; $ mv slime-* ~/.emacs.d/slime
;; ~/.emacs.d/slimeをload-pathに追加
(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;; SLIMEのロード
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner slime-indentation))
;; SLIMEからの入力をUTF-8に設定
(setq slime-net-coding-system 'utf-8-unix)

;; popwin
;; http://d.hatena.ne.jp/m2ym/20110120/1295524932
(require 'popwin)
;; Apropos)
(push '("*slime-apropos*") popwin:special-display-config)
;; Macroexpand
(push '("*slime-macroexpansion*") popwin:special-display-config)
;; Help
(push '("*slime-description*") popwin:special-display-config)
;; Compilation
(push '("*slime-compilation*" :noselect t) popwin:special-display-config)
;; Cross-reference
(push '("*slime-xref*") popwin:special-display-config)
;; Debugger
(push '(sldb-mode :stick t) popwin:special-display-config)
;; REPL
(push '(slime-repl-mode) popwin:special-display-config)
;; Connections
(push '(slime-connection-list-mode) popwin:special-display-config)

;; ac-slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
