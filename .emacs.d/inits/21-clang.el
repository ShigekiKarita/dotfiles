(setq c-default-style "bsd"
      c-basic-offset 4)


(require 'smart-compile)
(setq smart-compile-alist
      (append
       '(("\\.[Cc]+[Pp]*\\'" .
          "g++ %f -o %n -O2 -Wall -Wextra -std=c++1y -I/usr/local/boost/include -L/usr/local/boost/lib && ./%n"))
       smart-compile-alist))


(require 'flycheck)
(flycheck-define-checker c/c++
  "A C/C++ checker using clang."
  :command ("g++" "-Wall" "-Wextra" "-std=c++1y" "-I/usr/local/boost/include -L/usr/local/boost/lib" source)
  :error-patterns  ((error line-start
                           (file-name) ":" line ":" column ":" " Error: " (message)
                           line-end)
                    (warning line-start
                           (file-name) ":" line ":" column ":" " Warn: " (message)
                           line-end))
  :modes (c-mode c++-mode))



(setq-default c-default-style "bsd"
              c-basic-offset 4)
(add-hook 'c-mode-hook '(lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook '(lambda () (setq tab-width 4)))
(add-hook 'c++-mode-hook '(lambda () (flycheck-mode t)))
(add-hook 'c++-mode-hook '(lambda () (setq skeleton-pair 1)))
(add-hook 'c++-mode-hook '(lambda () (flycheck-select-checker 'c/c++)))
