;; -*- coding: utf-8; lexical-binding: t; -*-

(add-hook 'after-init-hook 'global-company-mode)

;; evil has already integrated company-mode, see evil-integration.el

(defvar my-company-zero-key-for-filter nil
  "If t, pressing 0 calls `company-filter-candidates' per company's status.")

(with-eval-after-load 'company

  ;; company changed the default key bindings, un-comment below code to restore original key bindings
  ;; @see https://github.com/company-mode/company-mode/wiki/Tips-%26-tricks/_compare/5ea840d^...5ea840d

  ;; (define-key company-active-map (kbd "C-n") nil)
  ;; (define-key company-active-map (kbd "C-p") nil)
  ;; (define-key company-active-map (kbd "M-n") #'company-select-next)
  ;; (define-key company-active-map (kbd "M-p") #'company-select-previous)

  (defun my-company-number ()
    ;; "Forward to `company-complete-number'.
;; Unless the number is potentially part of the candidate.
;; In that case, insert the number."
    (interactive)
    (let* ((k (this-command-keys))
           (re (concat "^" company-prefix k))
           (n (if (equal k "0") 10 (string-to-number k))))
      (cond
       ((or (cl-find-if (lambda (s) (string-match re s)) company-candidates)
            (> n (length company-candidates))
            (looking-back "[0-9]+\\.[0-9]*" (line-beginning-position)))
        (self-insert-command 1))

       ((and (eq n 10) my-company-zero-key-for-filter)
        (company-filter-candidates))

       (t
        (company-complete-number n)))))

  ;; @see https://github.com/company-mode/company-mode/issues/348
  (company-statistics-mode)
  (push 'company-cmake company-backends)
  (push 'company-c-headers company-backends)
  ;; can't work with TRAMP
  (setq company-backends (delete 'company-ropemacs company-backends))

  ;; @see https://oremacs.com/2017/12/27/company-numbers/
  ;; Using digits to select company-mode candidates
  (let ((map company-active-map))
    (mapc
     (lambda (x)
       (define-key map (format "%d" x) 'my-company-number))
     (number-sequence 0 9)))

  (setq company-auto-commit t)
  ;; characters "/ ) . , ;"to trigger auto commit
  (setq company-auto-commit-chars '(92  41 46 44 59))

  ;; company-ctags is much faster out of box. No further optimiation needed
  (unless (featurep 'company-ctags) (local-require 'company-ctags))
  (company-ctags-auto-setup)

  (setq company-backends (delete 'company-capf company-backends))

  ;; I don't like the downcase word in company-dabbrev
  (setq company-dabbrev-downcase nil
        ;; make previous/next selection in the popup cycles
        company-selection-wrap-around t
        ;; Some languages use camel case naming convention,
        ;; so company should be case sensitive.
        company-dabbrev-ignore-case nil
        ;; press M-number to choose candidate
        company-show-numbers t
        company-idle-delay 0.2
        company-clang-insert-arguments nil
        company-require-match nil
        company-ctags-ignore-case t ; I use company-ctags instead
        ;; @see https://github.com/company-mode/company-mode/issues/146
        company-tooltip-align-annotations t)

  ;; Press SPACE will accept the highlighted candidate and insert a space
  ;; "M-x describe-variable company-auto-complete-chars" for details.
  ;; So that's BAD idea.
  (setq company-auto-complete nil)

  ;; NOT to load company-mode for certain major modes.
  ;; Ironic that I suggested this feature but I totally forgot it
  ;; until two years later.
  ;; https://github.com/company-mode/company-mode/issues/29
  (setq company-global-modes
        '(not
          eshell-mode
          comint-mode
          erc-mode
          gud-mode
          rcirc-mode
          minibuffer-inactive-mode)))

;; (with-eval-after-load 'company-ispell
;;   (defun my-company-ispell-available-hack (orig-func &rest args)
;;     ;; in case evil is disabled
;;     (my-ensure 'evil-nerd-commenter)
;;     (cond
;;      ((and (derived-mode-p 'prog-mode)
;;            (or (not (company-in-string-or-comment)) ; respect advice in `company-in-string-or-comment'
;;                ;; I renamed the api in new version of evil-nerd-commenter
;;                (not (if (fboundp 'evilnc-pure-comment-p) (evilnc-pure-comment-p (point))
;;                       (evilnc-is-pure-comment (point)))))) ; auto-complete in comment only
;;       ;; only use company-ispell in comment when coding
;;       nil)
;;      (t
;;       (apply orig-func args))))
;;   (advice-add 'company-ispell-available :around #'my-company-ispell-available-hack))

;; (defun my-add-ispell-to-company-backends ()
;;   "Add ispell to the last of `company-backends'."
;;   (setq company-backends
;;         (add-to-list 'company-backends 'company-ispell)))

;; {{ setup company-ispell
;; (defun toggle-company-ispell ()
;;   "Toggle company-ispell."
;;   (interactive)
;;   (cond
;;    ((memq 'company-ispell company-backends)
;;     (setq company-backends (delete 'company-ispell company-backends))
;;     (message "company-ispell disabled"))
;;    (t
;;     (my-add-ispell-to-company-backends)
;;     (message "company-ispell enabled!"))))

;; (defun company-ispell-setup ()
;;   ;; @see https://github.com/company-mode/company-mode/issues/50
;;   (when (boundp 'company-backends)
;;     (make-local-variable 'company-backends)
;;     (my-add-ispell-to-company-backends)
;;     ;; @see https://github.com/redguardtoo/emacs.d/issues/473
;;     (cond
;;      ((and (boundp 'ispell-alternate-dictionary)
;;            ispell-alternate-dictionary)
;;       (setq company-ispell-dictionary ispell-alternate-dictionary))
;;      (t
;;        (setq company-ispell-dictionary (file-truename (concat my-emacs-d "misc/english-words.txt")))))))

;; message-mode use company-bbdb.
;; So we should NOT turn on company-ispell
;; (add-hook 'org-mode-hook 'company-ispell-setup)
;; }}

;;company-box
;; Better sorting and filtering
(use-package company-prescient
     :init (company-prescient-mode 1))

(use-package company-quickhelp
  :requires init-general
  :after company
  :custom
  (company-quickhelp-delay 3)
  :config
  (general-define-key
   :keymaps 'company-active-map
   "C-c h" 'company-quickhelp-manual-begin))

;; (use-package company-shell
;;   :config
;;   (add-to-list 'company-backends 'company-shell))

;; (require 'quelpa-use-package)
;;company-tabnine
(use-package company-tabnine
    ;; :quelpa (company-tabnine :fetcher github :repo "TommyX12/company-tabnine")
    :defer 1
    :custom
    (company-tabnine-max-num-results 9)
    :bind
    (("M-q" . company-other-backend)
     ("M-t" . company-tabnine))
    :init
    (setq company-tabnine-always-trigger nil)
    (defun company-tabnine-toggle (&optional enable)
      "Enable/Disable TabNine. If ENABLE is non-nil, definitely enable it."
      (interactive)
      (if (or enable (not (memq 'company-tabnine company-backends)))
          (progn
            (add-hook 'lsp-after-open-hook #'lsp-after-open-tabnine)
            (add-to-list 'company-backends #'company-tabnine)
            (when (bound-and-true-p lsp-mode) (lsp-after-open-tabnine))
            (message "TabNine enabled."))
        (setq company-backends (delete 'company-tabnine company-backends))
        (setq company-backends (delete '(company-capf :with company-tabnine :separate) company-backends))
        (remove-hook 'lsp-after-open-hook #'lsp-after-open-tabnine)
        (company-tabnine-kill-process)
        (message "TabNine disabled.")))
    (defun company//sort-by-tabnine (candidates)
      "Integrate company-tabnine with lsp-mode"
      (if (or (functionp company-backend)
              (not (and (listp company-backend) (memq 'company-tabnine company-backends))))
          candidates
        (let ((candidates-table (make-hash-table :test #'equal))
              candidates-lsp
              candidates-tabnine)
          (dolist (candidate candidates)
            (if (eq (get-text-property 0 'company-backend candidate)
                    'company-tabnine)
                (unless (gethash candidate candidates-table)
                  (push candidate candidates-tabnine))
              (push candidate candidates-lsp)
              (puthash candidate t candidates-table)))
          (setq candidates-lsp (nreverse candidates-lsp))
          (setq candidates-tabnine (nreverse candidates-tabnine))
          (nconc (seq-take candidates-tabnine 3)
                 (seq-take candidates-lsp 6)))))
    (defun lsp-after-open-tabnine ()
      "Hook to attach to `lsp-after-open'."
      (setq-local company-tabnine-max-num-results 3)
      (add-to-list 'company-transformers 'company//sort-by-tabnine t)
      (add-to-list 'company-backends '(company-capf :with company-tabnine :separate)))
    :hook
    (kill-emacs . company-tabnine-kill-process)
    :config
    (company-tabnine-toggle t)
    )

;;company-yasnippet
(use-package company
  :diminish
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :commands company-cancel
  :bind (("M-/" . company-complete)
         ("C-M-i" . company-complete)
         :map company-mode-map
         ("<backtab>" . company-yasnippet)
         :map company-active-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next)
         ("<tab>" . company-complete-common-or-cycle)
         ("<backtab>" . my-company-yasnippet)
         :map company-search-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next))
  ;; :hook (after-init . global-company-mode)
  :init
  (global-company-mode)
  (setq company-tooltip-align-annotations t
        company-tooltip-limit 12
        company-show-numbers t
        company-idle-delay 0
        company-echo-delay (if (display-graphic-p) nil 0)
        company-minimum-prefix-length 1;;最小匹配字符数
        company-require-match nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-global-modes '(not erc-mode message-mode help-mode
                                   gud-mode eshell-mode shell-mode)
        company-backends '(
                           (
                            ;; company-ispell :with company-yasnippet
                            ;; company-tabnine
                            ;; company-capf :with company-yasnippet
                            ;; company-keywords :with company-yasnippet
                                             ;; company-capf
                                        company-tabnine :with company-yasnippet
                            )
                           (company-dabbrev-code company-keywords company-files)
                           company-dabbrev)
        tab-always-indent 'complete
        )
  ;; (add-hook 'python-mode-hook
  ;;            (lambda ()
  ;;              (set (make-local-variable 'company-backends) '(company-capf)))
  ;;             )
  ;; (defun my/python-mode-hook ()
  ;;   (add-to-list 'company-backends 'company-jedi))

  ;; (add-hook 'python-mode-hook 'my/python-mode-hook)

  (defun my-company-yasnippet ()
    "Hide the current completeions and show snippets."
    (interactive)
    (company-cancel)
    (call-interactively 'company-yasnippet))
  :config
  ;; `yasnippet' integration
  (with-no-warnings
    (with-eval-after-load 'yasnippet
      (defun company-backend-with-yas (backend)
        "Add `yasnippet' to company backend."
        (if (and (listp backend) (member 'company-yasnippet backend))
            backend
          (append (if (consp backend) backend (list backend))
                  '(:with company-yasnippet))))

      (defun my-company-enbale-yas (&rest _)
        "Enable `yasnippet' in `company'."
        (setq company-backends (mapcar #'company-backend-with-yas company-backends)))

      (defun my-lsp-fix-company-capf ()
          "Remove redundant `comapny-capf'."
          (setq company-backends
                (remove 'company-backends (remq 'company-capf company-backends))))
       (advice-add #'lsp-completion--enable :after #'my-lsp-fix-company-capf)

      (defun my-company-yasnippet-disable-inline (fun command &optional arg &rest _ignore)
        "Enable yasnippet but disable it inline."
        (if (eq command 'prefix)
            (when-let ((prefix (funcall fun 'prefix)))
              (unless (memq (char-before (- (point) (length prefix)))
                            '(?. ?< ?> ?\( ?\) ?\[ ?{ ?} ?\" ?' ?`))
                prefix))
          (progn
            (when (and (bound-and-true-p lsp-mode)
                       arg (not (get-text-property 0 'yas-annotation-patch arg)))
              (let* ((name (get-text-property 0 'yas-annotation arg))
                     (snip (format "%s (Snippet)" name))
                     (len (length arg)))
                (put-text-property 0 len 'yas-annotation snip arg)
                (put-text-property 0 len 'yas-annotation-patch t arg)))
            (funcall fun command arg))))
      (advice-add #'company-yasnippet :around #'my-company-yasnippet-disable-inline))))

;;   ;; (use-package company
;;   ;;   :diminish
;;   ;;   :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
;;   ;;   :commands company-cancel
;;   ;;   :bind (("M-/" . company-complete)
;;   ;;          ("C-M-i" . company-complete)
;;   ;;          :map company-mode-map
;;   ;;          ("<backtab>" . company-yasnippet)
;;   ;;          :map company-active-map
;;   ;;          ("C-p" . company-select-previous)
;;   ;;          ("C-n" . company-select-next)
;;   ;;          ("<tab>" . company-complete-common-or-cycle)
;;   ;;          ("<backtab>" . my-company-yasnippet)
;;   ;;          :map company-search-map
;;   ;;          ("C-p" . company-select-previous)
;;   ;;          ("C-n" . company-select-next))
;;   ;;   :hook (after-init . global-company-mode)
;;   ;;   :init
;;   ;;   (setq company-tooltip-align-annotations t
;;   ;;         company-tooltip-limit 12
;;   ;;         company-idle-delay 0
;;   ;;         company-echo-delay (if (display-graphic-p) nil 0)
;;   ;;         company-minimum-prefix-length 1
;;   ;;         company-require-match nil
;;   ;;         company-dabbrev-ignore-case nil
;;   ;;         company-dabbrev-downcase nil
;;   ;;         company-global-modes '(not erc-mode message-mode help-mode
;;   ;;                                    gud-mode eshell-mode shell-mode)
;;   ;;         company-backends '(
;;   ;; ;; (company-ctag :with company-yasnippet)
;;   ;;                            (company-capf :with company-yasnippet)
;;   ;;                            (company-dabbrev-code company-keywords company-files)
;;   ;;                            company-dabbrev))

;;   ;;   (defun my-company-yasnippet ()
;;   ;;     "Hide the current completeions and show snippets."
;;   ;;     (interactive)
;;   ;;     (company-cancel)
;;   ;;     (call-interactively 'company-yasnippet))
;;   ;;   :config
;;   ;;   ;; `yasnippet' integration
;;   ;;   (with-no-warnings
;;   ;;     (with-eval-after-load 'yasnippet
;;   ;;       (defun company-backend-with-yas (backend)
;;   ;;         "Add `yasnippet' to company backend."
;;   ;;         (if (and (listp backend) (member 'company-yasnippet backend))
;;   ;;             backend
;;   ;;           (append (if (consp backend) backend (list backend))
;;   ;;                   '(:with company-yasnippet))))

;;   ;;       (defun my-company-enbale-yas (&rest _)
;;   ;;         "Enable `yasnippet' in `company'."
;;   ;;         (setq company-backends (mapcar #'company-backend-with-yas company-backends)))

;;   ;;       (defun my-lsp-fix-company-capf ()
;;   ;;         "Remove redundant `comapny-capf'."
;;   ;;         (setq company-backends
;;   ;;               (remove 'company-backends (remq 'company-capf company-backends))))
;;   ;;       (advice-add #'lsp-completion--enable :after #'my-lsp-fix-company-capf)

;;   ;;       (defun my-company-yasnippet-disable-inline (fun command &optional arg &rest _ignore)
;;   ;;         "Enable yasnippet but disable it inline."
;;   ;;         (if (eq command 'prefix)
;;   ;;             (when-let ((prefix (funcall fun 'prefix)))
;;   ;;               (unless (memq (char-before (- (point) (length prefix)))
;;   ;;                             '(?. ?< ?> ?\( ?\) ?\[ ?{ ?} ?\" ?' ?`))
;;   ;;                 prefix))
;;   ;;           (progn
;;   ;;             (when (and (bound-and-true-p lsp-mode)
;;   ;;                        arg (not (get-text-property 0 'yas-annotation-patch arg)))
;;   ;;               (let* ((name (get-text-property 0 'yas-annotation arg))
;;   ;;                      (snip (format "%s (Snippet)" name))
;;   ;;                      (len (length arg)))
;;   ;;                 (put-text-property 0 len 'yas-annotation snip arg)
;;   ;;                 (put-text-property 0 len 'yas-annotation-patch t arg)))
;;   ;;             (funcall fun command arg))))
;;   ;;       (advice-add #'company-yasnippet :around #'my-company-yasnippet-disable-inline)))

;;   ;; ;;   ;; Better sorting and filtering
;;   ;; ;;   (use-package company-prescient
;;   ;; ;;     :init (company-prescient-mode 1))

  ;;   ;; Icons and quickhelp
    (when emacs/>=26p
      (use-package company-box
        :diminish
        :defines company-box-icons-all-the-icons
        :hook (company-mode . company-box-mode)
        :init (setq company-box-enable-icon centaur-icon
                    company-box-backends-colors nil
                    company-box-doc-delay 0.3)
        :config
        (with-no-warnings
          ;; Prettify icons
          (defun my-company-box-icons--elisp (candidate)
            (when (or (derived-mode-p 'emacs-lisp-mode) (derived-mode-p 'lisp-mode))
              (let ((sym (intern candidate)))
                (cond ((fboundp sym) 'Function)
                      ((featurep sym) 'Module)
                      ((facep sym) 'Color)
                      ((boundp sym) 'Variable)
                      ((symbolp sym) 'Text)
                      (t . nil)))))
          (advice-add #'company-box-icons--elisp :override #'my-company-box-icons--elisp))

        (when (icons-displayable-p)
          (declare-function all-the-icons-faicon 'all-the-icons)
          (declare-function all-the-icons-material 'all-the-icons)
          (declare-function all-the-icons-octicon 'all-the-icons)
          (setq company-box-icons-all-the-icons
                `((Unknown . ,(all-the-icons-material "find_in_page" :height 0.8 :v-adjust -0.15))
                  (Text . ,(all-the-icons-faicon "text-width" :height 0.8 :v-adjust -0.02))
                  (Method . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
                  (Function . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
                  (Constructor . ,(all-the-icons-faicon "cube" :height 0.8 :v-adjust -0.02 :face 'all-the-icons-purple))
                  (Field . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
                  (Variable . ,(all-the-icons-octicon "tag" :height 0.85 :v-adjust 0 :face 'all-the-icons-lblue))
                  (Class . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
                  (Interface . ,(all-the-icons-material "share" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
                  (Module . ,(all-the-icons-material "view_module" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
                  (Property . ,(all-the-icons-faicon "wrench" :height 0.8 :v-adjust -0.02))
                  (Unit . ,(all-the-icons-material "settings_system_daydream" :height 0.8 :v-adjust -0.15))
                  (Value . ,(all-the-icons-material "format_align_right" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-lblue))
                  (Enum . ,(all-the-icons-material "storage" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
                  (Keyword . ,(all-the-icons-material "filter_center_focus" :height 0.8 :v-adjust -0.15))
                  (Snippet . ,(all-the-icons-material "format_align_center" :height 0.8 :v-adjust -0.15))
                  (Color . ,(all-the-icons-material "palette" :height 0.8 :v-adjust -0.15))
                  (File . ,(all-the-icons-faicon "file-o" :height 0.8 :v-adjust -0.02))
                  (Reference . ,(all-the-icons-material "collections_bookmark" :height 0.8 :v-adjust -0.15))
                  (Folder . ,(all-the-icons-faicon "folder-open" :height 0.8 :v-adjust -0.02))
                  (EnumMember . ,(all-the-icons-material "format_align_right" :height 0.8 :v-adjust -0.15))
                  (Constant . ,(all-the-icons-faicon "square-o" :height 0.8 :v-adjust -0.1))
                  (Struct . ,(all-the-icons-material "settings_input_component" :height 0.8 :v-adjust -0.15 :face 'all-the-icons-orange))
                  (Event . ,(all-the-icons-octicon "zap" :height 0.8 :v-adjust 0 :face 'all-the-icons-orange))
                  (Operator . ,(all-the-icons-material "control_point" :height 0.8 :v-adjust -0.15))
                  (TypeParameter . ,(all-the-icons-faicon "arrows" :height 0.8 :v-adjust -0.02))
                  (Template . ,(all-the-icons-material "format_align_left" :height 0.8 :v-adjust -0.15)))
                company-box-icons-alist 'company-box-icons-all-the-icons))))

;;   ;; ;;   ;; Popup documentation for completion candidates
;;   ;; ;;   (when (and (not emacs/>=26p) (display-graphic-p))
;;   ;; ;;     (use-package company-quickhelp
;;   ;; ;;       :defines company-quickhelp-delay
;;   ;; ;;       :bind (:map company-active-map
;;   ;; ;;              ([remap company-show-doc-buffer] . company-quickhelp-manual-begin))
;;   ;; ;;       :hook (global-company-mode . company-quickhelp-mode)
;;   ;; ;;       :init (setq company-quickhelp-delay 0.5))))
;;    )








(provide 'init-company)
