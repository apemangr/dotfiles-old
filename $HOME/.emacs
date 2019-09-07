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
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(cursor-type (quote bar))
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" "5f27195e3f4b85ac50c1e2fac080f0dd6535440891c54fcfa62cdcefedf56b1b" default)))
 '(delete-selection-mode t)
 '(display-line-numbers t)
 '(ede-project-directories (quote ("/home/apeman")))
 '(frame-resize-pixelwise t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (page-break-lines all-the-icons dashboard latex-extra latex-preview-pane latex-unicode-math-mode org-bullets auctex auto-complete-c-headers auto-complete iedit flycheck solarized-theme ido-vertical-mode treemacs yasnippet quickrun monokai-theme)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tex-directory "/home/apeman/Downloads/tree-dvips/")
 '(tex-main-file "")
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 113 :width normal)))))

;Yasnippet
;(require 'yasnippet)
(yas-global-mode 1)
(define-key global-map (kbd "C-c C-y") 'yas-new-snippet)

;Para activar el autorun
(global-set-key (kbd "<f5>") 'quickrun-shell)

;Doble signo automático
(electric-pair-mode 1)
(setq electric-pair-pairs
      '(
        (?\" . ?\")
	(?\< . ?\>)
        (?\{ . ?\})))

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

;Move lines with ALT
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;Ido-mode-vertical
(ido-mode 1)
(ido-vertical-mode 1)

;iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;Auto-complete
;(require 'auto-complete)
;(require 'auto-complete-config)
(setq ac-auto-show-menu 0)
(ac-config-default)

;Treemacs
(define-key global-map (kbd "C-c t") 'treemacs)

;flycheck
(global-flycheck-mode)

	
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(setq TeX-view-program-list '(("zathura" "zathura --page=%(outpage) %o")))

;org-bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;Dashboard
(dashboard-setup-startup-hook)
(setq dashboard-set-footer nil)
