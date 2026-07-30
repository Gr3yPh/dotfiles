;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("adbcf269aaae0e40c9d30c244f8a7dc64d4ae719a2ff9e6c46931212cb3d4ee0"
     "98fa2c2a5c9cc2e3fa435a42727f604b1dea5b4cad4aaef47942f2f9ee1e0a1b"
     default))
 '(package-selected-packages
   '(auto-complete company flycheck go-mode lsp-ui lua-mode srcery-theme
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

(use-package eglot
  :ensure t
  :hook (
         ;; 为指定语言自动启用 eglot
         (c++-mode . eglot-ensure)
         (c-mode . eglot-ensure)
         (go-mode . eglot-ensure)
         (python-mode . eglot-ensure)
         (java-mode . eglot-ensure)
         (web-mode . eglot-ensure)
         (js-mode . eglot-ensure)
         (css-mode . eglot-ensure)
         )
  :config
  ;; 设置 eglot 自动补全触发延迟（可选）
  (setq eglot-connect-timeout 30)
  ;; 让 eglot 使用 company 补全（如果安装了 company）
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq company-backends '(company-capf))
              (company-mode))))
