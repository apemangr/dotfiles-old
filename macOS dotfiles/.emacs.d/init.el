(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(flycheck-c/c++-cppcheck-executable nil)
 '(frame-resize-pixelwise t)
 '(inhibit-startup-screen t)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (flycheck helm company-lsp company yasnippet quickrun doom-modeline use-package)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(package-initialize)
(require 'package)
(setq package-enable-at-startup nil)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package lsp-mode
  :commands lsp
  :ensure t
  :hook(c-mode . lsp))


(use-package ccls
  :init (setq ccls-executable "/usr/local/bin/ccls")
  (setq ccls-initialization-options
        '(:clang (:extraArgs ["-isystem"
			      "/usr/local/opt/llvm/include/c++/v1"]
                  :resourceDir "/usr/local/opt/llvm/lib/clang/10.0.0"))))


(setenv "PATH" (concat (getenv "PATH")
		       ":/usr/local/bin"
		       ))

(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-one t))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))



(show-paren-mode 1)
(electric-pair-mode 1)
(setq electric-pair-pairs
'(
  (?\" . ?\")
  (?\' . ?\')
  (?\{ . ?\})))



(use-package quickrun
  :ensure t
  :bind("<f5>". 'quickrun-shell))

(use-package yasnippet
  :ensure t
  :config
    (yas-reload-all))
(define-key global-map (kbd "C-c C-y") 'yas-new-snippet)
(defun yas/org-very-safe-expand ()
(let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
(lambda ()
(make-variable-buffer-local 'yas/trigger-key)
(setq yas/trigger-key [tab])
(add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
(define-key yas/keymap [tab] 'yas/next-field)))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2))
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "<tab>") #'company-abort))
(add-hook 'c++-mode-hook 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)
(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'yas-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "->") t nil)))))
  (defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))
  (defun tab-indent-or-complete ()
    (interactive)
    (if (minibufferp)
        (minibuffer-complete)
      (if (or (not yas/minor-mode)
              (null (do-yas-expand)))
          (if (check-expansion)
              (company-complete-common)
            (indent-for-tab-command)))))
(global-set-key [tab] 'tab-indent-or-complete)
(add-hook 'after-init-hook 'global-company-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp)

(use-package helm
:ensure t
:init
(helm-mode 1)
:bind
  ("C-x C-f" . 'helm-find-files)
  ("C-x C-b" . 'helm-buffers-list)
  ("M-x" . 'helm-M-x))
(helm-autoresize-mode 1)
 
(set-default-font "Monaco-16")

(use-package flymake
  :init (flymake-mode-off))

(use-package flycheck
  :init (flycheck-mode nil))

