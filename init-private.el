;;freq use key
;; (global-set-key (kbd "C-c C-s") 'thing-cut-symbol)

;;edit line
;; (defun smarter-move-beginning-of-line (arg)
;;   "Move point back to indentation of beginning of line.

;; Move point to the first non-whitespace character on this line.
;; If point is already there, move to the beginning of the line.
;; Effectively toggle between the first non-whitespace character and
;; the beginning of the line.

;; If ARG is not nil or 1, move forward ARG - 1 lines first.  If
;; point reaches the beginning or end of the buffer, stop there."
;;   (interactive "^p")
;;   (setq arg (or arg 1))

;;   ;; Move lines first
;;   (when (/= arg 1)
;;     (let ((line-move-visual nil))
;;       (forward-line (1- arg))))

;;   (let ((orig-point (point)))
;;     (back-to-indentation)
;;     (when (= orig-point (point))
;;       (move-beginning-of-line 1))))
;; remap C-a to `smarter-move-beginning-of-line'
;; (global-set-key [remap move-beginning-of-line]
;;                 'smarter-move-beginning-of-line)

;; ;; unset a key
;; (global-set-key (kbd "C-c C-a") 'smarter-move-beginning-of-line)

;; 改变evil-insert-mode光标形状
;; (setq-default evil-insert-state-cursor '("green" (bar . 2)))

;;flycheck要成功运行,必须添加以下代码
(require 'exec-path-from-shell)
;; ;;toc-org
(if (require 'toc-org nil t)
    (progn
      (add-hook 'org-mode-hook 'toc-org-mode)
       ;; enable in markdown, too
      (add-hook 'markdown-mode-hook 'toc-org-mode)
      ;; (define-key markdown-mode-map (kbd "\C-c\C-o") 'toc-org-markdown-follow-thing-at-point)
      )
  (warn "toc-org not found"))

;;cpputils
;; (add-to-list 'load-path "~/.spacemacs.d/private/cpputils-cmake")
;; (require 'cpputils-cmake)

;; 全局展示line number
;;(global-display-line-numbers-mode)

;;color-moccur
;; (add-to-list 'load-path "~/.spacemacs.d/private/color-moccur")
;; (require 'color-moccur)
;; zshrc
;; (let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
;;   (setenv "PATH" path)
;;   (setq exec-path
;;         (append
;;          (split-string-and-unquote path ":")
;;          exec-path)))
;; electric-indent-mode
;; (electric-indent-mode -1)

;;geeknote.el
;; (add-to-list 'load-path "~/.spacemacs.d/private/emacs-geeknote")
;; (require 'geeknote)
;; (setq geeknote-command "python ~/.spacemacs.d/private/geeknote/geeknote/geeknote.py")
;; (defun geeknote-create (title)
;;   "Create a new note with the given title.

;; TITLE the title of the new note to be created."
;;   (interactive "sName: ")
;;   (message (format "geeknote creating note: %s" title))
;;   (let ((note-title (geeknote--parse-title title))
;; 	      (note-tags (geeknote--parse-tags title))
;; 	      (note-notebook (geeknote--parse-notebook title)))
;;     (async-shell-command
;;      (format (concat geeknote-command " create --content WRITE --title %s "
;;                      (when note-notebook " --notebook %s"))
;;              (shell-quote-argument note-title)
;;              (shell-quote-argument (or note-tags ""))
;;              (shell-quote-argument (or note-notebook ""))))))
;;posframe
(add-to-list 'load-path "~/.spacemacs.d/private/posframe")
(require 'posframe)
;;company-posframe
(add-to-list 'load-path "~/.spacemacs.d/private/posframe/company-posframe")
(require 'company-posframe)

;;rime
(add-to-list 'load-path "~/.spacemacs.d/private/emacs-rime")
(require 'rime)

(setq rime-posframe-properties
      (list :background-color "#333333"
            :foreground-color "#dcdccc"
            ;; :font "WenQuanYi Micro Hei Mono-14"
            :internal-border-width 10))

(setq default-input-method "rime"
      rime-show-candidate 'posframe)

(setq rime-user-data-dir "~/Library/Rime")

;; ;; ivy-posframe 占用内存
;; (ivy-posframe-mode 1)
;;snails
;; (add-to-list 'load-path "~/.spacemacs.d/private/snails")
;; (require 'snails)
;;delete-block
;; (add-to-list 'load-path "~/.spacemacs.d/private/delete-block")
;; (require 'delete-block)
;;kill-ring-search
;; (add-to-list 'load-path "~/.spacemacs.d/private/kill-ring-search")
;; (require 'kill-ring-search)

;; doi
;; (add-to-list 'load-path "~/.spacemacs.d/private/doi")
;; (require 'doi)

;;go-translate
;; (setq go-translate-base-url "https://translate.google.cn")

;; (setq go-translate-local-language "en")
;; (setq go-translate-buffer-follow-p t)       ; 翻译完成后，总是将光标切换到翻译结果窗口
;; (setq go-translate-buffer-source-fold-p t)  ; 在结果页面，折叠源文本。可以通过回车或鼠标点击展开
;; (setq go-translate-buffer-line-wrap-p nil)  ; 在结果页面，不允许过长的行折行显示
;; (setq go-translate-buffer-window-config ..) ; 更改翻译窗口的位置和样式
;; 设置输入风格。默认情况下，是通过 Minibuffer 方式补全用户输入
;; 可以修改为 `go-translate-inputs-noprompt` 或 `go-translate-inputs-current-or-prompt`
;; 前者表示直接翻译选中内容或光标下单词；后者表示若光标下没内容则打开 Minibuffer 读取内容
;; (setq go-translate-inputs-function #'go-translate-inputs-current-or-prompt)
;; (defun go-translate-raise-error-when-nothing-at-point ()
;;   (interactive)
;;   (let ((go-translate-inputs-function #'go-translate-inputs-noprompt))
;;     (call-interactively #'go-translate)))

;; (defun go-translate-continue-prompt-from-user-when-nothing-at-point ()
;;   (interactive)
;;   (let ((go-translate-inputs-function #'go-translate-inputs-current-or-prompt))
;;     (call-interactively #'go-translate)))
;; (setq go-translate-inputs-function #'go-translate-inputs-current-or-prompt)
;; (advice-add #'go-translate-text-local-p :filter-args
;;             (lambda (args)
;;               (setf (car args)
;;                     (with-temp-buffer
;;                       (insert (car args))
;;                       (replace-regexp "\\s." "" nil (point-min) (point-max))
;;                       (buffer-string)))
;;               args))
;; (setq go-translate-local-language "zh-CN")
;; (setq go-translate-target-language "en")
;; ;; You can bind keys for them. such as:
;; (global-set-key "\C-ct" 'go-translate)
;; (global-set-key "\C-cT" 'go-translate-popup)
;; ;; (setq go-translate-extra-directions '(("zh-CN" . "en") ("en" . "zh-CN")))

;;company-mode-add-digit
;(defun ora-company-number ()
;  "Forward to `company-complete-number'.
;
;Unless the number is potentially part of the candidate.
;In that case, insert the number."
;  (interactive)
;  (let* ((k (this-command-keys))
;         (re (concat "^" company-prefix k)))
;    (if (cl-find-if (lambda (s) (string-match re s))
;                    company-candidates)
;        (self-insert-command 1)
;      (company-complete-number (string-to-number k)))))
;
;(let ((map company-active-map))
;  (mapc
;   (lambda (x)
;     (define-key map (format "%d" x) 'ora-company-number))
;   (number-sequence 0 9))
;  (define-key map " " (lambda ()
;                        (interactive)
;                        (company-abort)
;                        (self-insert-command 1)))
;  (define-key map (kbd "<return>") nil))

;;motion
;; e ,r 移动
;(define-key evil-normal-state-map "e" 'evil-forward-symbol-begin)
;(define-key evil-normal-state-map "r" 'evil-forward-symbol-end)
;; (define-key evil-normal-state-map "E" 'evil-forward-symbol-end)
;(define-key evil-normal-state-map "b" 'evil-backward-symbol-begin)
;; (define-key evil-normal-state-map ";" 'evil-repeat-find-char-or-evil-backward-symbol-begin)
;(define-key evil-normal-state-map "R" 'evil-backward-symbol-end)

;(define-key evil-visual-state-map "e" 'evil-forward-symbol-begin)
;(define-key evil-visual-state-map "r" 'evil-forward-symbol-end)
;; (define-key evil-visual-state-map "E" 'evil-forward-symbol-end)
;(define-key evil-visual-state-map "b" 'evil-backward-symbol-begin)
;(define-key evil-visual-state-map "R" 'evil-backward-symbol-end)

;; de dr
;(define-key evil-motion-state-map "e" 'evil-forward-symbol-end)
;(define-key evil-motion-state-map "r" 'evil-backward-symbol-begin)
;; dae die
;(define-key evil-outer-text-objects-map "e" 'evil-a-symbol)
;(define-key evil-inner-text-objects-map "e" 'evil-inner-symbol)


;;;autoload
;(evil-define-motion evil-forward-symbol-begin(count)
;  "Move to the end of the COUNT-th next symbol."
;  ;; :jump t
;  :type exclusive
;  (evil-signal-at-bob-or-eob count)
;  (evil-forward-beginning 'evil-symbol count)
;  (let ((sym (thing-at-point 'evil-symbol)))
;    (while (and sym (not (string-match "\\<" sym)))
;      (evil-forward-beginning 'evil-symbol 1)
;      (setq sym (thing-at-point 'evil-symbol))
;      )
;    )
;  )

;;;autoload
;(evil-define-motion evil-backward-symbol-begin(count)
;  "Move to the end of the COUNT-th next symbol."
;  ;; :jump t
;  :type exclusive
;  ;; (evil-signal-at-bob-or-eob count)
;  ;; (forward-evil-symbol count)
;  (evil-backward-beginning 'evil-symbol count)
;  (let ((sym (thing-at-point 'evil-symbol)))
;    (while (and sym (not (string-match "\\<" sym)))
;      (evil-backward-beginning 'evil-symbol 1)
;      (setq sym (thing-at-point 'evil-symbol)))))


;;;autoload
;(evil-define-motion evil-forward-symbol-end(count)
;  "Move to the end of the COUNT-th next symbol."
;  ;; :jump t
;  :type exclusive
;  (evil-signal-at-bob-or-eob count)
;  (forward-evil-symbol count)
;
;  ;; (let ((sym (thing-at-point 'evil-symbol)))
;  ;;   (while (and sym (not (string-match "^\\<" sym)))
;  ;;     (evil-forward-end 'evil-symbol 1)
;  ;;     (setq sym (thing-at-point 'evil-symbol))
;  ;;     )
;  ;;   )
;  )

;;;autoload
;(evil-define-motion evil-backward-symbol-end(count)
;  "Move to the end of the COUNT-th next symbol."
;  ;; :jump t
;  :type exclusive
;  (evil-signal-at-bob-or-eob count)
;  (evil-backward-end 'symbol count)
;  (let ((sym (thing-at-point 'evil-symbol)))
;    (while (and sym (not (string-match "\\<" sym)))
;      (evil-backward-end 'evil-symbol 1)
;      (setq sym (thing-at-point 'evil-symbol))
;      )
;    )
;)

;; quela
;; (quelpa
;;  '(quelpa-use-package
;;    :fetcher git
;;    :url "https://github.com/quelpa/quelpa-use-package.git"))

;;company-box
;; (quelpa
;;  '(company-box
;;    :fetcher git
;;    :url "https://github.com/sebastiencs/company-box.git"))
;; (require 'company-box)

;;lpy
(use-package lpy
  :quelpa (lpy :fetcher github :repo "abo-abo/lpy")
  :ensure t
  :config
  (add-hook 'python-mode-hook #'lpy-mode))

;;awesome-tab
;; (add-to-list 'load-path "~/.spacemacs.d/private/awesome-tab")
;; (require 'awesome-tab)
;; (awesome-tab-mode t)

;;awesome-tab
(use-package awesome-tab
  :quelpa (awesome-tab :fetcher github :repo "manateelazycat/awesome-tab")
  :ensure t
  :config
  (awesome-tab-mode 1)
  )

;;aweshell
(use-package aweshell
  :quelpa (aweshell :fetcher github :repo "manateelazycat/aweshell")
  :ensure t
  )

;;lazy-set-key
(add-to-list 'load-path "~/.spacemacs.d/private/lazy-set-key")
(require 'lazy-set-key)

;;lazy-load
(add-to-list 'load-path "~/.spacemacs.d/private/lazy-load")
(require 'lazy-load)

;; auto-save
(add-to-list 'load-path "~/.spacemacs.d/private/auto-save") ; add auto-save to your load-path
(require 'auto-save)
(auto-save-enable)
(setq auto-save-silent t)   ; quietly save
(setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving

;;; custom predicates if you don't want auto save.
;;; disable auto save mode when current filetype is an gpg file.
;(setq auto-save-disable-predicates
;      '((lambda ()
;          (string-suffix-p
;           "gpg"
;           (file-name-extension (buffer-name)) t))))

;;ox-gfm
;; (add-to-list 'load-path "~/.spacemacs.d/private/ox-gfm") ; add auto-save to your load-path
;; (eval-after-load "org"
;;   '(require 'ox-gfm nil t))

;; rainbow-delimiters
(add-to-list 'load-path "~/.spacemacs.d/private/rainbow-delimiters") ; add auto-save to your load-path
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'org-mode-hook #'rainbow-delimiters-mode)
(add-hook 'python-mode-hook #'rainbow-delimiters-mode)

;; ov-hight
(add-to-list 'load-path "~/.spacemacs.d/private/ov-highlight") ; add auto-save to your load-path
(require 'ov-highlight)

;; plain-org-wiki
(add-to-list 'load-path "~/.spacemacs.d/private/plain-org-wiki") ; add auto-save to your load-path
(require 'plain-org-wiki)
(setq plain-org-wiki-directory "~/Documents/坚果云/我的坚果云/github/wiki/")

;;valign
;; (add-to-list 'load-path "~/.spacemacs.d/private/valign") ; add auto-save to your load-path
;; (require 'valign)
;; (add-hook 'org-mode-hook #'valign-mode)
;; (use-package valign
;;   :quelpa (valign :fetcher github :repo "casouri/valign")
;;   :ensure t
;;   :config
;;   (add-hook 'org-mode-hook #'valign-mode))

;;org table 对齐
(use-package valign
  :quelpa (valign :fetcher github :repo "casouri/valign")
  :ensure t
  :config
  (add-hook 'org-mode-hook #'valign-mode))

;;awesome-pair
(add-to-list 'load-path "~/.spacemacs.d/private/awesome-pair") ; add auto-save to your load-path
(require 'awesome-pair)
(dolist (hook (list
               'c-mode-common-hook
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'org-mode-hook
               ;; 'haskell-mode-hook
               'emacs-lisp-mode-hook
               'lisp-interaction-mode-hook
               'lisp-mode-hook
               ;; 'maxima-mode-hook
               ;; 'ielm-mode-hook
               'sh-mode-hook
               ;; 'makefile-gmake-mode-hook
               ;; 'php-mode-hook
               'python-mode-hook
               ;; 'js-mode-hook
               ;; 'go-mode-hook
               ;; 'qml-mode-hook
               ;; 'jade-mode-hook
               ;; 'css-mode-hook
               ;; 'ruby-mode-hook
               ;; 'coffee-mode-hook
               ;; 'rust-mode-hook
               ;; 'qmake-mode-hook
               ;; 'lua-mode-hook
               ;; 'swift-mode-hook
               'minibuffer-inactive-mode-hook
               ))

  (add-hook hook '(lambda () (awesome-pair-mode 1))))

(define-key awesome-pair-mode-map (kbd "C-q") 'awesome-pair-open-round)
(define-key awesome-pair-mode-map (kbd "[") 'awesome-pair-open-bracket)
(define-key awesome-pair-mode-map (kbd "{") 'awesome-pair-open-curly)
(define-key awesome-pair-mode-map (kbd ")") 'awesome-pair-close-round)
(define-key awesome-pair-mode-map (kbd "]") 'awesome-pair-close-bracket)
(define-key awesome-pair-mode-map (kbd "}") 'awesome-pair-close-curly)
(define-key awesome-pair-mode-map (kbd "=") 'awesome-pair-equal)
(define-key awesome-pair-mode-map (kbd "%") 'awesome-pair-match-paren)
(define-key awesome-pair-mode-map (kbd "\"") 'awesome-pair-double-quote)
(define-key awesome-pair-mode-map (kbd "SPC") 'awesome-pair-space)
(define-key awesome-pair-mode-map (kbd "M-o") 'awesome-pair-backward-delete)
(define-key awesome-pair-mode-map (kbd "C-d") 'awesome-pair-forward-delete)
(define-key awesome-pair-mode-map (kbd "C-k") 'awesome-pair-kill)
(define-key awesome-pair-mode-map (kbd "M-\"") 'awesome-pair-wrap-double-quote)
(define-key awesome-pair-mode-map (kbd "M-[") 'awesome-pair-wrap-bracket)
(define-key awesome-pair-mode-map (kbd "M-{") 'awesome-pair-wrap-curly)
(define-key awesome-pair-mode-map (kbd "M-(") 'awesome-pair-wrap-round)
(define-key awesome-pair-mode-map (kbd "M-)") 'awesome-pair-unwrap)
(define-key awesome-pair-mode-map (kbd "M-p") 'awesome-pair-jump-right)
(define-key awesome-pair-mode-map (kbd "M-n") 'awesome-pair-jump-left)
(define-key awesome-pair-mode-map (kbd "M-:") 'awesome-pair-jump-out-pair-and-newline)
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(electric-pair-mode 1)

;;org-download
;; (add-to-list 'load-path "~/.spacemacs.d/private/org-download") ; add auto-save to your load-path
;; (require 'org-download)

;; Drag-and-drop to `dired`
;; (add-hook 'dired-mode-hook 'org-download-enable)

;; pyim
;; (add-to-list 'load-path "~/.emacs.d/elpa/pyim-20201130.309") ; add auto-save to your load-path
;; (require 'pyim)

;; (use-package pyim
;;   :ensure nil
;;   :demand t
;;   :after ivy
;;   :config

;;   ;; 添加ivy拼音支持
;;   (defun eh-ivy-cregexp (str)
;;     (let ((x (ivy--regex-plus str))
;;           (case-fold-search nil))
;;       (if (listp x)
;;           (mapcar (lambda (y)
;;                     (if (cdr y)
;;                         y
;;                       (list (pyim-cregexp-build (car y))))
;;                     x))
;;         (pyim-cregexp-build x))))

;;   (setq ivy-re-builders-alist
;;         '((t . eh-ivy-cregexp)))

;;   :config
;;   ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
;;   (use-package pyim-basedict
;;     :ensure nil
;;     :config (pyim-basedict-enable))

;;   ;; (setq default-input-method "pyim")

;;   ;; 我使用全拼
;;   (setq pyim-default-scheme 'pyim-shuangpin)

;;   ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;;   ;; 我自己使用的中英文动态切换规则是：
;;   ;; 1. 光标只有在注释里面时，才可以输入中文。
;;   ;; 2. 光标前是汉字字符时，才能输入中文。
;;   ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
;;   (setq-default pyim-english-input-switch-functions
;;                 '(pyim-probe-dynamic-english
;;                   pyim-probe-isearch-mode
;;                   pyim-probe-program-mode
;;                   pyim-probe-org-structure-template))

;;   (setq-default pyim-punctuation-half-width-functions
;;                 '(pyim-probe-punctuation-line-beginning
;;                   pyim-probe-punctuation-after-punctuation))

;;   ;; 开启拼音搜索功能
;;   (pyim-isearch-mode 1)

;;   ;; 使用 popup-el 来绘制选词框, 如果用 emacs26, 建议设置
;;   ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
;;   ;; 手动安装 posframe 包。
;;   ;; (setq pyim-page-tooltip 'posframe)

;;   ;; 选词框显示5个候选词
;;   ;; (setq pyim-page-length 7)

;;   :bind
;;   (("C-S-P" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
;;    ("C-;" . pyim-delete-word-from-personal-buffer)))


;; 中文字体设置
(cnfonts-enable)

;; rime
;; (use-package rime
;;   :custom
;;   (default-input-method "rime")
;;   :config
;;   ;; (setq rime-user-data-dir "~/Library/Rime")
;;   ;; (setq rime-posframe-properties
;;   ;; 	(list :background-color "#333333"
;;   ;;           :foreground-color "#dcdccc"
;;   ;;           :internal-border-width 10))

;;   )

;; (add-to-list 'load-path "~/.spacemacs.d/private/color-rg") ; add color-rg to your load-path
;; (require 'color-rg)

;unicode
(add-to-list 'load-path "~/.emacs.d/elpa/unicode-escape-20160614.1234") ; add color-rg to your load-path
(require 'unicode-escape)

;; color-rg
(use-package color-rg
  :quelpa (color-rg :fetcher github :repo "manateelazycat/color-rg")
  :ensure t
  )

;; company-tabnine
(add-to-list 'load-path "~/.emacs.d/elpa/company-tabnine-20210310.2247/") ; add color-rg to your load-path
(require 'company-tabnine)

;; ;;evil-snipe
;; ;; (evil-snipe-override-mode 1)
;; ;; 恢复evil的s/S，要用evil-define-key, define-key不行，a bit tricky，一个issue里抄来的
;; (with-eval-after-load 'evil-snipe
;;   (evil-define-key* '(normal) evil-snipe-mode-map
;;                     "s" #'evil-substitute
;;                     "S" #'evil-change-whole-line)
;;   (define-key evil-normal-state-map "s" #'evil-substitute)
;;   (define-key evil-normal-state-map "S" #'evil-change-whole-line)
;;   )
;; ;;只用来repeat，禁用移动后立即按f/t来repeat
;; (setq evil-snipe-repeat-keys nil)
;; ;; override-mode之后如果要给evil-repeat绑其他键位要用evil-snipe的对应函数
;; (define-key evil-normal-state-map (kbd "DEL") 'evil-snipe-repeat-reverse)
;; ;; 不用s/S那用gs之类的吧
;; (evil-define-key 'normal evil-snipe-mode-map (kbd "g s") #'evil-snipe-s)
;; (evil-define-key 'normal evil-snipe-mode-map (kbd "g S") #'evil-snipe-S)
;; (evil-define-key 'normal evil-snipe-mode-map (kbd "g t") #'evil-snipe-x)
;; (evil-define-key 'normal evil-snipe-mode-map (kbd "g T") #'evil-snipe-X)
;; (evil-define-key 'visual evil-snipe-mode-map "z" #'evil-snipe-s)
;; (evil-define-key 'visual evil-snipe-mode-map "Z" #'evil-snipe-S)
;; (evil-define-key 'visual evil-snipe-mode-map "x" #'evil-snipe-x)
;; (evil-define-key 'visual evil-snipe-mode-map "X" #'evil-snipe-X)

;;olivetti
;; (require 'olivetti)

;;avy
;;行内字符移动
;; (defun avy-goto-word-1-backward-in-line (char &optional arg)
;;   (interactive (list (read-char "char: " t)
;;                      current-prefix-arg))
;;   (avy-goto-word-1 char arg (point-at-bol) (point) nil))

;; (defun avy-goto-word-1-forward-in-line (char &optional arg)
;;   (interactive (list (read-char "char: " t)
;;                      current-prefix-arg))
;;   (avy-goto-word-1 char arg (point) (point-at-eol) nil))

;; (use-package evil-lispy
;;   :quelpa (evil-lispy :fetcher github :repo "sp3ctum/evil-lispy")
;;   :ensure t
;;   :config
;;   (add-hook 'org-mode-hook #'evil-lispy-mode)
;;   (add-hook 'emacs-lisp-mode-hook #'evil-lispy-mode)
;;   (add-hook 'clojure-mode-hook #'evil-lispy-mode)
;;   )
;; smex
;; (require 'smex)                       ; Not needed if you use package.el
;; (smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)

;;smex
(use-package smex
  :quelpa (smex :fetcher github :repo "nonsequitur/smex")
  :ensure t
  )

;; google-translate
;; (add-to-list 'load-path "~/.spacemacs.d/private/google-translate") ; add color-rg to your load-path
;; (require 'google-translate)
;; load color theme
;; (add-to-list 'load-path "~/.spacemacs.d/private/color-theme")
;; (require 'color-theme)
;; (load-file "~/Dropbox/emacs/emacs-24.3/etc/themes/tango-light-theme.el")
;; (color-theme-initialize)
;; (color-theme-aliceblue)
;;multi-translate
;; (add-to-list 'load-path "~/.spacemacs.d/private/multi-translate.el") ; add color-rg to your load-path
;; (require 'multi-translate)

;;org-wiki
;(add-to-list 'load-path "~/.spacemacs.d/private/org-wiki") ; add color-rg to your load-path
;(require 'org-wiki)

;; org-noter
;; (add-to-list 'load-path "~/.spacemacs.d/private/org-noter") ; add color-rg to your load-path
;; (require 'org-noter)

;;python
;;paredit-mode
;; (add-hook 'prog-mode-hook 'paredit-mode)
;; (add-hook 'python-mode-hook 'paredit-mode)
;; (add-hook 'org-mode-hook 'paredit-mode)
;; ;;mwe-log-commands
;; (add-to-list 'load-path "~/.spacemacs.d/private/mwe-log-commands")
;; (require 'mwe-log-commands)
;; ;;shell-command-extension
;; (add-to-list 'load-path "~/.spacemacs.d/private/shell-command-extension")
;; (require 'shell-command-extension)
;; ;;basic-toolkit
;; (add-to-list 'load-path "~/.spacemacs.d/private/basic-toolkit")
;; (require 'basic-toolkit)
;; ;;lazycat-toolkit
;; (add-to-list 'load-path "~/.spacemacs.d/private/lazycat-toolkit")
;; (require 'lazycat-toolkit)
;; ;;paredit-extension
;; (add-to-list 'load-path "~/.spacemacs.d/private/paredit-extension")
;; (require 'paredit-extension)

;;高亮当前行
(use-package hl-line
  :ensure nil
  :hook (after-init . global-hl-line-mode))

;;hide{} 内容
;; (use-package hideshow
;;   :ensure nil
;;   :diminish hs-minor-mode
;;   :bind (:map prog-mode-map
;;               ("C-c TAB" . hs-toggle-hiding)
;;               ("M-+" . hs-show-all))
;;   :hook (prog-mode . hs-minor-mode)
;;   :custom
;;   (hs-special-modes-alist
;;    (mapcar 'purecopy
;;            '((c-mode "{" "}" "/[*/]" nil nil)
;;              (c++-mode "{" "}" "/[*/]" nil nil)
;;              (rust-mode "{" "}" "/[*/]" nil nil)))))

;;显示空白
;; (use-package whitespace
;;   :hook (after-init . global-whitespace-mode)
;;   :config
;;   ;; Don't use different background for tabs.
;;   (face-spec-set 'whitespace-tab
;;                  '((t :background unspecified)))
;;   ;; Only use background and underline for long lines, so we can still have
;;   ;; syntax highlight.

;;   ;; For some reason use face-defface-spec as spec-type doesn't work.  My guess
;;   ;; is it's due to the variables with the same name as the faces in
;;   ;; whitespace.el.  Anyway, we have to manually set some attribute to
;;   ;; unspecified here.
;;   (face-spec-set 'whitespace-line
;;                  '((((background light))
;;                     :background "#d8d8d8" :foreground unspecified
;;                     :underline t :weight unspecified)
;;                    (t
;;                     :background "#404040" :foreground unspecified
;;                     :underline t :weight unspecified)))

;;   ;; Use softer visual cue for space before tabs.
;;   (face-spec-set 'whitespace-space-before-tab
;;                  '((((background light))
;;                     :background "#d8d8d8" :foreground "#de4da1")
;;                  (t
;;                     :inherit warning
;;                     :background "#404040" :foreground "#ee6aa7")))

;;   (setq
;;    whitespace-line-column nil
;;    whitespace-style
;;    '(face             ; visualize things below:
;;      empty            ; empty lines at beginning/end of buffer
;;      lines-tail       ; lines go beyond `fill-column'
;;      space-before-tab ; spaces before tab
;;      trailing         ; trailing blanks
;;      tabs             ; tabs (show by face)
;;      tab-mark         ; tabs (show by symbol)
;;      )))

;; (use-package so-long
;;   :ensure nil
;;   :config (global-so-long-mode 1))

;; (use-package autorevert
;;   :ensure nil
;;   :hook (after-init . global-auto-revert-mode))

;;isolate
;; (add-to-list 'load-path "~/.spacemacs.d/private/isolate")
;; (require 'isolate)

;; evil-easymotion
;; (add-to-list 'load-path "~/.spacemacs.d/private/evil-easymotion")
;; (require 'evil-easymotion)

;; Globally
;; (evil-snipe-override-mode 1)
;; (define-key evil-snipe-parent-transient-map (kbd "C-,")
;;   (evilem-create 'evil-snipe-repeat
;;                  :bind ((evil-snipe-scope 'buffer)
;;                         (evil-snipe-enable-highlight)
;;                         (evil-snipe-enable-incremental-highlight))))

;; thingatpt
(add-to-list 'load-path "~/.spacemacs.d/private/thingatpt")
(require 'thingatpt)

;;thing-edit
(add-to-list 'load-path "~/.spacemacs.d/private/thing-edit")
(require 'thing-edit)

;;one-key
(add-to-list 'load-path "~/.spacemacs.d/private/one-key")
(require 'one-key)

;;lispy
;; (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
;; (add-hook 'org-mode-hook (lambda () (lispy-mode 1)))
;; (add-hook 'python-mode-hook (lambda () (lispy-mode 1)))
;; (add-hook 'ipython-mode-hook (lambda () (lispy-mode 1)))

;; (eval-after-load "lispy"
;;   `(progn
;;      ;; replace a global binding with own function
;;      (define-key lispy-mode-map (kbd "C-e") 'my-custom-eol)
;;      ;; replace a global binding with major-mode's default
;;      (define-key lispy-mode-map (kbd "C-j") nil)
;;      ;; replace a local binding
;;      (lispy-define-key lispy-mode-map "s" 'lispy-down)
;;      (lispy-define-key lispy-mode-map "w" 'lispy-up)))

;; lispyville
;; (add-hook 'lispy-mode-hook #'lispyville-mode)
;; (add-hook 'org-mode-hook #'lispyville-mode)
;; (with-eval-after-load 'lispyville
;;   (lispyville-set-key-theme
;;    '(operators
;;      c-w
;;      (escape insert)
;;      (additional-movement normal visual motion))))

;; (evil-define-key 'normal lispyville-mode-map
;;   ",,"  #'lispyville-comment-or-uncomment
;;   ",."  #'lispyville-comment-and-clone-dwim
;;   ",ci" #'lispyville-comment-or-uncomment-line
;;   ">" #'lispyville-slurp
;;   "<" #'lispyville-barf
;;   ",{" #'lispyville-wrap-braces
;;   ",[" #'lispyville-wrap-brackets
;;   ",w" #'lispyville-drag-backward
;;   ",x" #'lispyville-move-down
;;   ",f" #'lispyville-forward-atom
;;   ",b" #'lispyville-backward-atom-end
;;   ",s" #'lispyville-a-string
;;   ",l" #'lispyville-a-list
;;   )


;; (setq bibtex-completion-bibliography "~/Dropbox/bibliography/references.bib"
;;       bibtex-completion-library-path "~/Dropbox/bibliography/bibtex-pdfs"
;;       bibtex-completion-notes-path "~/Dropbox/bibliography/helm-bibtex-notes")

;;ebib
;; (require 'general)
;; (use-package ebib
;;   :general
;;   ([f5] 'ebib)
;;   (ebib-multiline-mode-map
;;    "C-c C-c" 'ebib-quit-multiline-buffer-and-save
;;    "C-c C-q" 'ebib-cancel-multiline-buffer
;;    "C-c C-s" 'ebib-save-from-multiline-buffer)
;;   :custom
;;   (bibtex-autokey-name-case-convert-function 'capitalize)
;;   (bibtex-autokey-titlewords 0)
;;   (bibtex-autokey-year-length 4)
;;   (ebib-uniquify-keys t)
;;   (ebib-bibtex-dialect 'biblatex)
;;   (ebib-index-window-size 10)
;;   (ebib-preload-bib-files '("~/Dropbox/bibliography/references.bib"))
;;   (ebib-notes-use-single-file "~/Dropbox/Bibliography/Notes.org")
;;   (ebib-file-search-dirs '("~/Dropbox/Bibliography/bibtex-pdfs/"))
;;   (ebib-reading-list-file "~/Dropbox/Bibliography/ReadingList.org")
;;   (ebib-keywords-file "~/Dropbox/Bibliography/ebib-keywords.txt")
;;   (ebib-keywords-field-keep-sorted t)
;;   (ebib-keywords-file-save-on-exit 'always)
;;   (ebib-file-associations '(("pdf")) "using Emacs to open pdf")
;;   (ebib-use-timestamp t "recording the time that entries are added")
;;   (ebib-index-columns '(("Entry Key" 20 t)
;; 			            ("Author/Editor" 40 nil)
;; 			            ("Year" 6 t)
;; 			            ("Title" 50 t)))
;;   (ebib-index-default-sort '("timestamp" . descend)))

;; (require 'init-hydra)
;; (use-package org-ref
;;   :general
;;   (z-spc-leader-def "r" 'org-ref-hydra/body)
;;   :pretty-hydra
;;   ((:color red :quit-key "q")
;;    ("Insert"
;;     (("i" org-ref-helm-insert-cite-link "citation key")
;;      ("r" org-ref-helm-insert-ref-link "ref link")
;;      ("l" org-ref-helm-insert-label-link "label link"))
;;     "Browse"
;;     (("b" helm-bibtex "bibtex")
;;      ("s" crossref-lookup "lookup"))
;;     "Add"
;;     (("a" crossref-add-bibtex-entry "new entry")
;;      ("d" doi-add-bibtex-entry "doi"))))
;;   :custom
;;   (bibtex-dialect 'biblatex)
;;   (org-ref-bibliography-notes "~/Dropbox/bibliography/helm-bibtex-notes")
;;   (org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib"))
;;   (org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")
;;   (org-ref-show-broken-links nil)
;;   (org-ref-default-ref-type "eqref")
;;   (org-ref-default-citation-link "citet")
;;   :config
;;   (require 'org-ref-citeproc)
;;   (defun org-ref-grep-pdf (&optional _candidate)
;;     "Search pdf files of marked CANDIDATEs."
;;     (interactive)
;;     (let ((keys (helm-marked-candidates))
;; 	  (get-pdf-function org-ref-get-pdf-filename-function))
;;       (helm-do-pdfgrep-1
;;        (-remove (lambda (pdf)
;; 		  (string= pdf ""))
;; 		(mapcar (lambda (key)
;; 			  (funcall get-pdf-function key))
;; 			keys)))))
;;   (helm-add-action-to-source "Grep PDF" 'org-ref-grep-pdf helm-source-bibtex 1)

;;   (setq helm-bibtex-map
;; 	(let ((map (make-sparse-keymap)))
;; 	  (set-keymap-parent map helm-map)
;; 	  (define-key map (kbd "C-s") (lambda () (interactive)
;; 					(helm-run-after-exit 'org-ref-grep-pdf)))
;; 	  map))
;;   (push `(keymap . ,helm-bibtex-map) helm-source-bibtex))


;;org-mode
;(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;(use-package company-math
;   :ensure t)

;  (use-package company-auctex
;    :ensure t
;    :config (progn
;              (defun company-auctex-labels (command &optional arg &rest ignored)
;                "company-auctex-labels backend"
;                (interactive (list 'interactive))
;                (case command
;                  (interactive (company-begin-backend 'company-auctex-labels))
;                  (prefix (company-auctex-prefix "\\\\.*ref{\\([^}]*\\)\\="))
;                  (candidates (company-auctex-label-candidates arg))))
;
;              (add-to-list 'company-backends
;                           '(company-auctex-macros
;                             company-auctex-environments
;                             company-math-symbols-unicode
;                             company-math-symbols-latex))
;
;              (add-to-list 'company-backends #'company-auctex-labels)
;              (add-to-list 'company-backends #'company-auctex-bibs)))

; (add-hook 'org-mode-hook 'company-mode)
;  (add-hook 'org-mode-hook
;            (lambda ()
;              (set (make-local-variable 'company-backends) '(company-capf company-yasnippet company-math-symbols-unicode ;company-math-symbols-latex company-files
 ;                                                                                         ;; company-en-words
 ;                                                                                         company-dabbrev)))
 ;           )

;;换行符
;; (define-fringe-bitmap 'right-curly-arrow
;;   [#b00000000
;;    #b00000000
;;    #b00000000
;;    #b00000000
;;    #b01110000
;;    #b00010000
;;    #b00010000
;;    #b00000000])
;; (define-fringe-bitmap 'left-curly-arrow
;;   [#b00000000
;;    #b00001000
;;    #b00001000
;;    #b00001110
;;    #b00000000
;;    #b00000000
;;    #b00000000
;;    #b00000000])

;; ivy-posframe-style
;; (require 'ivy-posframe)
;; display at `ivy-posframe-style'
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
;; Different command can use different display function.
;; (setq ivy-posframe-parameters
;;       '((left-fringe . 8)
;;         (right-fringe . 8)))
;; Different command can use different display function.
;; (setq ivy-posframe-display-functions-alist
;;       '((swiper          . ivy-posframe-display-at-frame-center)
;;         (counsel-recentf . ivy-posframe-display-at-window-center)
;;         (counsel-M-x     . ivy-posframe-display-at-window-center)
;;         (t               . ivy-posframe-display)))
;; (ivy-posframe-mode 1)

;; org-brain
;; (add-to-list 'load-path "~/.spacemacs.d/private/org-brain")
;; (require 'org-brain)

;; (use-package org-brain
;;   :ensure t
;;   :init
;;   (setq org-brain-path "~/Documents/坚果云/我的坚果云/github/wiki")
;;   ;; For Evil users
;;   (with-eval-after-load 'evil
;;     (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
;;   :config
;;   (bind-key "C-c b" 'org-brain-prefix-map org-mode-map)
;;   ;; (setq org-id-track-globally t)
;;   ;; (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
;;   ;; (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
;;   ;; (push '("b" "Brain" plain (function org-brain-goto-end)
;;   ;;         "* %i%?" :empty-lines 1)
;;   ;;       org-capture-templates)
;;   (setq org-brain-visualize-default-choices 'all)
;;   (setq org-brain-title-max-length 12)
;;   (setq org-brain-include-file-entries nil
;;         org-brain-file-entries-use-title nil))

;; Allows you to edit entries directly from org-brain-visualize
;; (use-package polymode
;;   :config
;;   (add-hook 'org-brain-visualize-mode-hook #'org-brain-polymode))


;; dired-mode
;; ;; ;;返回上层目录，我绑定了快捷键i, 特别好按，非常流畅
(add-hook 'dired-mode-hook
               (lambda ()
                 (define-key dired-mode-map (kbd "i")
                   (lambda () (interactive) (find-alternate-file "..")))))

;;; R related modes
(use-package polymode
  ;; :ensure markdown-mode
  ;; :ensure org-mode
  ;; :ensure python-mode
  ;; :ensure poly-R
  ;; :ensure poly-noweb
  :mode
  (("\\.Rmd" . poly-markdown+r-mode))
  (("\\.org" . poly-org-mode))
  :init
  ;; (autoload 'r-mode "ess-site.el" "Major mode for editing R source." t)
  ;; :defer t
  :config
  ;; (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.org" . poly-org-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Snw$" . poly-noweb+r-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Rnw$" . poly-noweb+r-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Rmd$" .  poly-markdown+r-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.rapport$" . poly-rapport-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Rhtml$" . poly-html+r-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Rbrew$" . poly-brew+r-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.Rcpp$" . poly-r+c++-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.cppR$" . poly-c++r-mode))
  )

;; poly-R
;; (use-package poly-R
;;   :ensure polymode
;;   :ensure poly-markdown
;;   :ensure poly-noweb
;;   :defer t
;;   :config
;;   ;; Add a chunk for rmarkdown
;;   ;; Need to add a keyboard shortcut
;;   ;; https://emacs.stackexchange.com/questions/27405/insert-code-chunk-in-r-markdown-with-yasnippet-and-polymode
;;   ;; (defun insert-r-chunk (header)
;;   ;;   "Insert an r-chunk in markdown mode. Necessary due to interactions between polymode and yas snippet"
;;   ;;   (interactive "sHeader: ")
;;   ;;   (insert (concat "```{r " header "}\n\n\n```"))
;;   ;;   (forward-line -2))
;;   ;; (define-key poly-markdown+r-mode-map (kbd "M-c") #'insert-r-chunk)
;; )

;;evil-escape
;(require 'evil-escape)
;(setq-default evil-escape-key-sequence "kj")
;(setq-default evil-escape-delay 0.2)

;;citre
; (quelpa
;  '(citre
;    :fetcher git
;    :url "https://github.com/universal-ctags/citre.git"))

; (require 'citre)
; (require 'citre-config)


;;org-roam
;; (quelpa
;;  '(org-roam
;;    :fetcher git
;;    :url "https://github.com/org-roam/org-roam.git"))

;;company-org-roam
;; (quelpa
;;  '(company-org-roam
;;    :fetcher git
;;    :url "https://github.com/jethrokuan/company-org-roam.git"))

;ess
;; (quelpa
;;  '(ESS
;;    :fetcher git
;;    :url "https://github.com/emacs-ess/ESS.git"))

;; (add-to-list 'load-path "/Users/luyajun/scimax/elpa/ess-20190708.1230")
;; (require 'ess)

;; (add-to-list 'load-path "/Users/luyajun/scimax/elpa/ess-smart-underscore-20190309.101")
;; (require 'ess-smart-underscore)

;;show-paren-function
(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
    echo area. Has no effect if the character before point is not of
    the syntax class ')'."
  (interactive)
  (let* (
     (cb (char-before (point)))
         (matching-text (and cb
                             (char-equal (char-syntax cb) ?\) )
                             (blink-matching-open)
            )
     )
    )
  )
 )


(provide 'init-private)
