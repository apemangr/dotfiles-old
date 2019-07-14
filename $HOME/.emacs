;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("5f27195e3f4b85ac50c1e2fac080f0dd6535440891c54fcfa62cdcefedf56b1b" default)))
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/")
     ("melpa-stable" . "https://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (iedit yasnippet auto-complete all-the-icons dashboard monokai-theme)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 120 :width normal)))))

;Dashboard
(require 'dashboard)
(setq dashboard-startup-banner 'logo)
(setq dashboard-show-shortcuts nil)
(dashboard-setup-startup-hook)

;Auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(setq ac-auto-show-menu 0)
(ac-config-default)

;Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)
