
;; Desactivar interfaz gráfica innecesaria
;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

;; Tamaño de fuente
(set-face-attribute 'default nil :height 110)

;; Configuración de paquetes
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; use-package para gestionar configuración
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; ============================================
;; 1. Modo EVIL (estilo Vim)
;; ============================================
(use-package evil
  :config
  (evil-mode 1))

;; ============================================
;; 2. Tema oscuro: Nord
;; ============================================
(use-package nord-theme
  :ensure t
  :config
  (load-theme 'nord t))

;; ============================================
;; 3. Soporte para C/C++ con LSP y autocompletado
;; ============================================

;; Autocompletado con company
(use-package company
  :hook (after-init . global-company-mode))

;; LSP para C/C++
(use-package lsp-mode
  :hook ((c-mode c++-mode) . lsp)
  :commands lsp
  :config
  (setq lsp-enable-symbol-highlighting t
	lsp-prefer-flymake nil))

(use-package lsp-ui
  :commands lsp-ui-mode)

;; Snippets (necesarios para LSP)
(use-package yasnippet
  :config
  (yas-global-mode 1))

;; ============================================
;; 4. Modo org básico
;; ============================================
(use-package org
  :pin gnu
  :config
  (setq org-hide-emphasis-markers t))

;; ============================================
;; 5. Git: Magit
;; ============================================
(use-package magit
  :commands magit-status)

;; ============================================
;; 6. GDB integrado
;; ============================================
(setq gdb-many-windows t)         ;; Modo IDE con múltiples ventanas
(setq gdb-show-main t)            ;; Mostrar punto de entrada al iniciar

;; ============================================
;; 7. Otras mejoras opcionales
;; ============================================

;; Mostrar atajos
(use-package which-key
  :config
  (which-key-mode))

;; Mejora del minibuffer
(use-package vertico
  :init
  (vertico-mode))

;; ============================================
;; 8. Ajustes adicionales útiles
;; ============================================
(require 'ox-md)									;; Load the 'markdown' backend

(setq make-backup-files nil)      ;; Sin archivos ~ de respaldo
(setq auto-save-default nil)      ;; Sin archivos # de auto guardado
(setq ring-bell-function 'ignore) ;; Sin pitido
;; (global-display-line-numbers-mode 1) ;; Números de línea
;; (menu-bar--display-line-numbers-mode-relative) ;; set relative number 
(column-number-mode t)   ;; set column number

;; =======================================================
;; Activar números de línea solo en modos de programación
;; =======================================================
(add-hook 'prog-mode-hook
          (lambda ()
            (display-line-numbers-mode 1) ;; Activa números de línea
            (menu-bar--display-line-numbers-mode-relative))) ;; Números relativos
            (setq-default display-line-numbers-width 3)
			(setq-default display-line-numbers-widen t)
			
;; === Ajustes en prueba ===

;; Disable warnings from the legacy advice API. They aren't useful.
(setq ad-redefinition-action 'accept)

;;; Show-paren

(setq show-paren-delay 0.1
      show-paren-highlight-openparen t
      show-paren-when-point-inside-paren t
      show-paren-when-point-in-periphery t)
      
;; Avoid backups or lockfiles to prevent creating world-readable copies of files
(setq create-lockfiles nil)
(setq make-backup-files nil)

;; Skip confirmation prompts when creating a new file or buffer
(setq confirm-nonexistent-file-or-buffer nil)

;;; = Auto save =

;; Enable auto-save to safeguard against crashes or data loss. The
;; `recover-file' or `recover-session' functions can be used to restore
;; auto-saved data.
(setq auto-save-default nil)
(setq auto-save-no-message t)

;; Auto save options
(setq kill-buffer-delete-auto-save-files t)

;; Remove duplicates from the kill ring to reduce clutter
(setq kill-do-not-save-duplicates t)

;;;  = Cursor =

;; The blinking cursor is distracting and interferes with cursor settings in
;; some minor modes that try to change it buffer-locally (e.g., Treemacs).
(blink-cursor-mode -1)

;; Don't blink the paren matching the one at point, it's too distracting.
(setq blink-matching-paren nil)

;;; == Custom settings ===

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
