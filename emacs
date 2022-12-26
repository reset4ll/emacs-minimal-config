(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(chart-face-color-list
   '("#b52c2c" "#4fd100" "#f1e00a" "#2fafef" "#bf94fe" "#47dfea" "#702020" "#007800" "#b08600" "#1f2f8f" "#5f509f" "#00808f"))
 '(custom-enabled-themes '(atom-one-dark))
 '(custom-safe-themes
   '("37046960cf667c5ab3b76235d35a5db4763c531e706502a9067fa78db5a775c0" "0f08efc35f1190204ac227e8c866b18400612d2137e2d13dcbf4693953681ff3" default))
 '(display-time-mode t)
 '(flymake-error-bitmap '(flymake-double-exclamation-mark ef-themes-mark-delete))
 '(flymake-note-bitmap '(exclamation-mark ef-themes-mark-select))
 '(flymake-warning-bitmap '(exclamation-mark ef-themes-mark-other))
 '(global-display-line-numbers-mode t)
 '(ibuffer-deletion-face 'ef-themes-mark-delete)
 '(ibuffer-filter-group-name-face 'bold)
 '(ibuffer-marked-face 'ef-themes-mark-select)
 '(ibuffer-title-face 'default)
 '(ispell-dictionary nil)
 '(package-selected-packages '(atom-one-dark-theme elpy flycheck ef-themes slime)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka Term" :foundry "UKWN" :slant normal :weight normal :height 128 :width normal)))))

;; Emacs Powerline - Ajustes.
(add-to-list 'load-path "/home/aesteban/.emacs.d/vendor/emacs-powerline")
(require 'powerline)

;; MELPA stable repository.
(require 'package)

(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
;;(package-initialize)

;; MELPA repository.
(require 'package)

(add-to-list 'package-archives
             '("MELPA Stable" . "https://melpa.org/packages/") t)
;;(package-initialize)

;; Configura comprobación de syntax: Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Pone números de linea.
(global-display-line-numbers-mode)

;; Enable ELPY
(package-initialize)
(elpy-enable)
