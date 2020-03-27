;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)
;;(require 'go-mode-load)

;; add Melpa archive to list of available repositories
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;; initialize the package infrastructure
(package-initialize)
;; if there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;;Install packages
;;
;;myPackages contains a list of package names

(defvar myPackages
  '(better-defaults ;; better emacs defaults
    elpy ;; add the elpy package
    flycheck ;; on the fly syntax checking 
    py-autopep8 ;; pep8
    material-theme ;; theme
    go-mode ;; go mode
    go-eldoc
    auto-complete
    go-autocomplete
    ))


;; scan the list in mypackages
;; if package listed is no already installed, install it
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally


;; PYTHON CONFIGURATION
;;enable elpy
(elpy-enable)


;; Use IPython for REPL
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")


;; enable flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)



;; GO CONFIGURATION

(defun go-mode-setup ()
  (go-eldoc-setup)
  (add-hook 'before-save-hook 'gofmt-before-save)
    (local-set-key (kbd "M-.") 'godef-jump)
    (local-set-key (kbd "M-*") 'pop-tag-mark)
    )
(add-hook 'go-mode-hook 'go-mode-setup)

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(global-auto-complete-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (go-guru go-autocomplete py-autopep8 material-theme go-mode go flycheck exec-path-from-shell elpy blacken better-defaults auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
