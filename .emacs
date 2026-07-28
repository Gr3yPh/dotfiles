;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   '("adbcf269aaae0e40c9d30c244f8a7dc64d4ae719a2ff9e6c46931212cb3d4ee0"
     "98fa2c2a5c9cc2e3fa435a42727f604b1dea5b4cad4aaef47942f2f9ee1e0a1b"
     default))
 '(package-selected-packages
   '(auto-complete company flycheck go-mode lsp-ui srcery-theme
                   year-1984-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
(electric-pair-mode 1)
(setq-default indent-tabs-mode nil)   
(setq-default tab-width 2)             
(setq indent-line-function 'insert-tab)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")   ;; 设置 LSP 快捷键前缀
  :hook (
         (c++-mode . lsp-deferred)   ; C++
         (c-mode . lsp-deferred)     ; C
         (go-mode . lsp-deferred)    ; Go
         (python-mode . lsp-deferred); Python
         (web-mode . lsp-deferred)   ; HTML/CSS/JS (如果用 web-mode)
         (js-mode . lsp-deferred)    ; JavaScript
         (js2-mode . lsp-deferred)   ; JavaScript (另一个流行模式)
         (css-mode . lsp-deferred)   ; CSS
         (java-mode . lsp-deferred)  ; Java
         )
  :config
  (setq lsp-idle-delay 0.1
        company-idle-delay 0.0
        company-minimum-prefix-length 1))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company
  :ensure t
  :config
  (global-company-mode))

;; 全局开启相对行号
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(use-package lsp-mode
  :config
  (setq lsp-diagnostics-provider :flycheck)  ; 改用 flycheck
  )

(use-package flycheck
  :config
  (global-flycheck-mode t))
