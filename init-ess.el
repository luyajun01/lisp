;;; init-ess.el --- Emacs Speaks Statistics -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; -------------------------------- ;;
;; ESS
;; -------------------------------- ;;

;; ess
;; Emacs Speaks Statistics
;; ess.r-project.org

(use-package ess
  :init
  (require 'ess-site)
  :config
  (setq inferior-R-program-name "/usr/local/bin/R"
      ess-ask-for-ess-directory nil
      ess-directory "/Users/luyajun/Documents/坚果云/我的坚果云/github/code/sim"
      ess-ask-about-transfile nil
      ess-use-auto-complete t
      ess-r-args-electric-paren t)

  (add-to-list 'auto-mode-alist '("\\.R$" . R-mode))
  (add-to-list 'auto-mode-alist '("\\.r$" . R-mode))
  )
  ;;(require 'ess-rutils)
  ;;(require 'ess-r-mode))

(provide 'init-ess)

;;; init-ess ends here
