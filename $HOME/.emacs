;8888888b.  8888888888 8888888888        d8888 888     888 888      88888888888 
;888  "Y88b 888        888              d88888 888     888 888          888     
;888    888 888        888             d88P888 888     888 888          888     
;888    888 8888888    8888888        d88P 888 888     888 888          888     
;888    888 888        888           d88P  888 888     888 888          888     
;888    888 888        888          d88P   888 888     888 888          888     
;888  .d88P 888        888         d8888888888 Y88b. .d88P 888          888     
;8888888P"  8888888888 888        d88P     888  "Y88888P"  88888888     888     
                                                                               
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
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (doom-one)))
 '(custom-safe-themes
   (quote
    ("2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" default)))
 '(frame-resize-pixelwise t)
 '(helm-completion-style (quote emacs))
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (dashboard doom-modeline doom-themes flycheck quickrun org-bullets auctex helm ido-vertical-mode company treemacs yasnippet)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 113 :width normal)))))



;8888888b.         d8888  .d8888b.  888    d8P         d8888  .d8888b.  8888888888  .d8888b.  
;888   Y88b       d88888 d88P  Y88b 888   d8P         d88888 d88P  Y88b 888        d88P  Y88b 
;888    888      d88P888 888    888 888  d8P         d88P888 888    888 888        Y88b.      
;888   d88P     d88P 888 888        888d88K         d88P 888 888        8888888     "Y888b.   
;8888888P"     d88P  888 888        8888888b       d88P  888 888  88888 888            "Y88b. 
;888          d88P   888 888    888 888  Y88b     d88P   888 888    888 888              "888 
;888         d8888888888 Y88b  d88P 888   Y88b   d8888888888 Y88b  d88P 888        Y88b  d88P 
;888        d88P     888  "Y8888P"  888    Y88b d88P     888  "Y8888P88 8888888888  "Y8888P"  

;;; YASNIPPET ;;;
(yas-global-mode 1)
(define-key global-map (kbd "C-c C-y") 'yas-new-snippet)
(defun yas/org-very-safe-expand ()
(let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
(add-hook 'org-mode-hook
(lambda ()
(make-variable-buffer-local 'yas/trigger-key)
(setq yas/trigger-key [tab])
(add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
(define-key yas/keymap [tab] 'yas/next-field)))


;;; COMPANY ;;;
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0)
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

;;; FLYCHECK ;;;
(global-flycheck-mode)

;;; ACE-WINDOW ;;;
(define-key global-map (kbd "M-o") 'ace-window)
(ace-window-display-mode 1)

;;; HELM ;;;
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;;; IDO-VERTICAL-MODE ;;;
(ido-mode 1)
(ido-vertical-mode 1)

;;; IEDIT ;;;
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;;; MOVE LINES WITH ALT ;;;
(defun move-line (n)
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    (forward-line -1)
    (forward-char col)))
(defun move-line-up (n)
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
(defun move-line-down (n)
  (interactive "p")
  (move-line (if (null n) 1 n)))
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;;; ORG-BULLETS ;;;
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;; QUICKRUN ;;;
(global-set-key (kbd "<f5>") 'quickrun-shell)

;;; AUTO PARENTESIS ;;;
  (electric-pair-mode 1)
  (setq electric-pair-pairs
	'(
	  (?\" . ?\")
	  (?\' . ?\')
	  (?\< . ?\>)
	  (?\{ . ?\})))

;;; DOOM MODELINE ;;;
(require 'doom-modeline)
  (doom-modeline-mode 1)
  (setq inhibit-compacting-font-caches t)

;;; DASHBOARD ;;;
(dashboard-setup-startup-hook)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-startup-banner 'logo)
