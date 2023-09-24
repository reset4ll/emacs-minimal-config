(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-collection cmake-mode modern-cpp-font-lock company-box company pyvenv python-mode dap-mode lsp-ivy lsp-treemacs lsp-ui powerline flycheck eglot magit counsel-projectile projectile hydra general doom-themes helpful counsel ivy-rich which-key rainbow-delimiters ivy command-log-mode use-package))
 '(warning-suppress-types '((comp))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
 '(default ((t (:family "Iosevka Term" :foundry "UKWN" :slant normal :weight normal :height 128 :width normal)))))

(setq inhibit-startup-message t)  ; Disable visible startup message

(scroll-bar-mode -1)              ; Disable visible toolbar
(tool-bar-mode -1)                ; Disable the toolbar
(tooltip-mode -1)                 ; Disable tooltips
(set-fringe-mode 10)              ; Give some breathing room

;;(menu-bar-mode -1)                ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code Retina" :height 110)

;;; KEYBINDINGS
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Make counsel-switch-buffer
;;

;; (load-theme 'wombat) ;; First theme installled -> doom-palenight after

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Set column-number-mode
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		treemacs-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; (use-package command-log-mode) ;; Disabled by the moment !!!

;; Set doom-themes
(use-package doom-themes
  :init (load-theme 'doom-one t))
  
;; Set powerline
(require 'powerline)
(powerline-center-theme)

;; Set ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Set ivy-rich
(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))


;; Set rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Set which-key
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

;; Set counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

;; Set helpful
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; general-keybindings
(use-package general
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys   ;; Define shortkeys on my own
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))))
  
 ;; Using EVIL mode
 (use-package evil
   :init
   (setq evil-want-integration t)
   (setq evil-want-keybinding nil)
   (setq evil-want-C-u-scroll t)
   (setq evil-want-C-i-jump nil)
   :config
   (evil-mode 1)
   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

   ;; Use visual line motions even outside of visual-line-mode buffers
   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

   (evil-set-initial-state 'messages-buffer-mode 'normal)
   (evil-set-initial-state 'dashboard-mode 'normal))

 ;; Set EVIL collection
 (use-package evil-collection
   :after evil
   :config
   (evil-collection-init))

(use-package hydra
  :defer t)

;; Set Hydra - Text scaling
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(efs/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

;; Set Projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Code")
    (setq projectile-project-search-path '("~/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

;; Set counsel-projectile
(use-package counsel-projectile   
  :after projectile
  :config (counsel-projectile-mode))

;; Set Magit
(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Set Forge  -- NOT INSTALLED BY THE MOMENT
;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
;; (use-package forge
;;  :after magit)

;;; --- LSP SETTINGS ---

;; Set LSP mode
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

;; Set LSP-ui
(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-max-width 80)
  (lsp-ui-doc-position 'bottom))

;; Set LSP-treemacs
(use-package lsp-treemacs
  :after lsp)

;; Set LSP-ivy
(use-package lsp-ivy
  :after lsp)

;; Set DAP-mode
(use-package dap-mode)
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;;:custom
  ;;(lsp-enable-dap-auto-configure nil)
  :config
  (dap-ui-mode 1)
  ;;:commands dap-debug
  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed

;; Support C/C++ for LSP-mode with 'eglot'
(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "/usr/bin/clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Support Python
(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :custom
  ;; NOTE: Set these if Python 3 is called "python3" on your system!
  (python-shell-interpreter "python3")
  (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

;; Set Company
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; Enable Flycheck
;; (add-hook 'after-init-hook #'global-flycheck-mode)

(use-package flycheck
  :diminish flycheck-mode
  :ensure t
  :defer t
  :custom
  (flycheck-check-syntax-automatically '(mode-enabled save)) ; Check on save instead of running constantly
  :hook ((prog-mode-hook text-mode-hook) . flycheck-mode))

(use-package flymake
  :ensure t
  :defer t)

;; ;; Set Flycheck-indent
;; (eval-after-load 'flycheck
;;   '(flycheck-indent-setup))

;;  =============================================
;;; === Custom settings for C/C++ programming ===
;;  =============================================

;; Set "linux" style indenting for C/C++ programming
(setq c-default-style "linux"
      c-basic-offset 4)

;; Turn on electric pair mode
(electric-pair-mode 1)

 (c-set-offset 'substatement-open 0)
	 (c-set-offset 'innamespace 0)
	 (c-set-offset 'brace-list-open 0)
	 (setq c-basic-offset 4)

	 (setq lsp-clients-clangd-args
		   '("-j=8"
			 "--header-insertion=never"
			 "--all-scopes-completion"
			 "--background-index"
			 "--clang-tidy"
			 "--compile-commands-dir=build"
			 "--cross-file-rename"
			 "--suggest-missing-includes"))

;; Set modern-cpp-font-lock
(use-package modern-cpp-font-lock
 :config
 (modern-c++-font-lock-global-mode))

;; Set cmake-mode
(use-package cmake-mode)



