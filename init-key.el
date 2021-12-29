;; Mac平台下交换 Option 和 Command 键。
(when (featurep 'cocoa)
  (setq mac-option-modifier 'super)
  (setq mac-command-modifier 'meta))
;;lazy-load
(add-to-list 'load-path "~/.spacemacs.d/private/lazy-load")
(require 'lazy-load)

(add-to-list 'load-path "~/.spacemacs.d/private/lazy-set-key")
(require 'lazy-set-key)
(require 'paredit)
(paredit-mode 1)
(lazy-unset-key                         ;全局按键的卸载
 '("C-/" "C-]" "C-c C-n" "C-c C-p" "M-g" "C-<return>" "C-l" "C-S-p" "C-r" "C-c C-e" "C-c C-b" "C-o" "C-s" "C-)" "C-S-j" "C-c h" "s-a" "C-a"))

;;; ### Aweshell ###
;;; --- 多标签式的shell
(require 'aweshell)
(lazy-load-global-keys
 '(
   ("s-a" . aweshell-new)
   ("s-h" . aweshell-toggle)
   ;; ("s-x s-x" . aweshell-dedicated-toggle)
   )
 "aweshell")

;; (lazy-load-global-keys
;;  '(
;;    ("M-x" . smex+)
;;    ("C-c C-c M-x" . execute-extended-command)
;;    )
;;  "init-smex")

;; (lazy-load-global-keys
;;  '(
;;    ("M-g" . goto-line-preview))
;;  "goto-line-preview")

;; (lazy-load-global-keys
;;  '(
;;    ("s-y" . snails)
;;    ("s-u" . snails-search-point)
;;    )
;;  "snails")
(require 'rime)
(lazy-set-key
 '(
("C-]" . toggle-input-method)
   ))

(require 'smartparens)
(lazy-set-key
 '(
   ("M-o" . backward-delete-char-untabify)
   ("C-/" . undo)                       ; 撤销
   ("C-?" . redo)                       ; TODO: 重做
   ("C-a" . smarter-move-beginning-of-line)
   ("C-c v" . split-window-vertically)
   ("C-c h" . split-window-horizontally)
   ("C-l" . my-python-line)
   ("C-c C-e" . sp-end-of-sexp)         ;smartparens end
   ("C-c C-b" . sp-beginning-of-sexp)
   ("C-<return>" . org-insert-heading)
   ("C-o" . org-insert-subheading)
   ;; ("C-S-j" . rime-inline-ascii)
   ;; ("C-S-p" . +rime-convert-string-at-point)
   ("C-S-p" . pyim-convert-string-at-point)
   ("C-r" . python-shell-send-region)
   ("C-c C-n" . scimax-ob-move-src-block-down)
   ("C-c C-p" . scimax-ob-move-src-block-up)
   ("s-a" . scimax-ob-ipython-complete-ivy)
   ("s-h" . scimax-ob-jump-to-header)
   ("C-)" . lispy-wrap-round)
   ;; ("C-q" . emac)        ;退出emacs
   ("C-x c" . delete-other-windows)
   ("M-4" . whitespace-cleanup)
   ("M-h" . set-mark-command)
   ;; ("M-g" . goto-line)
   ("C-:" . comment-or-uncomment-region+)
   ("M-l" . less-minor-mode)
   ("M-N" . kill-syntax-backward+)      ;向后进行语法删除
   ("M-M" . killn-syntax-forward+)      ;向前进行语法删除
   ("C-j" . paredit-newline)
   ("M-t" . multi-term-dedicated-toggle)
   ("M-m" . hide/show-comments-toggle)
   ("M-j" . sr-speedbar-toggle)
   ;; ("C-h" . dired-jump)
   ("<C-tab>" . tabbar-backward-tab)
   )
 )
;;; ### Unset key ###
;;; --- 卸载按键
(lazy-unset-key                         ;全局按键的卸载
 '("C-x C-f" "C-z" "C-q" "s-W" "s-z" "M-h" "C-\\" "s-c" "s-x" "s-v"))
;;; ### Vi-move ###
;;; --- Vi式移动
(defvar vi-move-key-alist nil
  "The key alist that like vi move.")
(setq vi-move-key-alist
      '(("j" . next-line)               ;上一行
        ("k" . previous-line)           ;下一行
        ("h" . backward-char)           ;向后移动
        ("l" . forward-char)            ;向前移动
        ("e" . scroll-down)             ;向下滚动一屏
        ("SPC" . scroll-up)))           ;向上滚动一屏

;;; ### Functin key ###
;; ;;; --- 功能函数
(lazy-load-set-keys
 '(
   ("<f5>" . emacs-session-save)        ;退出emacs
   ("C-4" . insert-changelog-date)      ;插入日志时间 (%Y/%m/%d)
   ("C-&" . switch-to-messages)         ;跳转到 *Messages* buffer
   ))

;;; ### Delete block ###
;;; --- 快速删除光标左右的内容
(lazy-load-global-keys
 '(
   ("M-N" . delete-block-backward)
   ("M-M" . delete-block-forward))
 "delete-block")
;;; ### Awesome-Pair ###
;;; --- 结构化编程
(add-to-list 'load-path "~/.spacemacs.d/private/awesome-pair") ; add auto-save to your load-path
(require 'awesome-pair)
(lazy-load-unset-keys
 '("M-J" "M-r" "M-s" "M-;" "C-M-f" "C-M-b" "M-)")
 awesome-pair-mode-map)                 ;卸载按键
(defvar awesome-pair-key-alist nil)
(setq awesome-pair-key-alist
      '(
        ;; 移动
        ("M-n" . awesome-pair-jump-left)
        ("M-p" . awesome-pair-jump-right)
        ;; 符号插入
        ("%" . awesome-pair-match-paren)       ;括号跳转
        ("(" . awesome-pair-open-round)        ;智能 (
        ("[" . awesome-pair-open-bracket)      ;智能 [
        ("{" . awesome-pair-open-curly)        ;智能 {
        (")" . awesome-pair-close-round)       ;智能 )
        ("]" . awesome-pair-close-bracket)     ;智能 ]
        ("}" . awesome-pair-close-curly)       ;智能 }
        ("\"" . awesome-pair-double-quote)     ;智能 "
        ("=" . awesome-pair-equal)             ;智能 =
        ("SPC" . awesome-pair-space)           ;智能 Space
        ;; 删除
        ("M-o" . awesome-pair-backward-delete) ;向后删除
        ("C-d" . awesome-pair-forward-delete)  ;向前删除
        ("C-k" . awesome-pair-kill)            ;向前kill
        ;; 包围
        ("M-\"" . awesome-pair-wrap-double-quote) ;用 " " 包围对象, 或跳出字符串
        ("M-[" . awesome-pair-wrap-bracket)       ;用 [ ] 包围对象
        ("M-{" . awesome-pair-wrap-curly)         ;用 { } 包围对象
        ("M-(" . awesome-pair-wrap-round)         ;用 ( ) 包围对象
        ("M-)" . awesome-pair-unwrap)             ;去掉包围对象
        ;; 跳出并换行缩进
        ("M-:" . awesome-pair-jump-out-pair-and-newline) ;跳出括号并换行
        ))
(lazy-load-set-keys awesome-pair-key-alist awesome-pair-mode-map)

;;; ### Color-Rg ###
;;; --- 搜索重构
(lazy-load-global-keys
 '(
   ("s-x g" . color-rg-search-symbol)
   ("s-x h" . color-rg-search-input)
   ("s-x j" . color-rg-search-symbol-in-project)
   ("s-x k" . color-rg-search-input-in-project)
   ("s-x ," . color-rg-search-symbol-in-current-file)
   ("s-x ." . color-rg-search-input-in-current-file)
   )
 "color-rg")

;;; ### Magit ###
(lazy-load-global-keys
 '(
   ("s-x f" . one-key-menu-magit))
 "init-git")

;; ;;; ### Sdcv ###
;; ;;; --- 星际译王命令行
;; (defvar sdcv-key-alist nil
;;   "The key alist that sdcv.")
;; (setq sdcv-key-alist
;;       '(("p" . sdcv-search-pointer)     ;光标处的单词, buffer显示
;;         ("y" . sdcv-search-pointer+)    ;光标处的单词, tooltip显示
;;         ("i" . sdcv-search-input)       ;输入的单词, buffer显示
;;         (";" . sdcv-search-input+)))    ;输入的单词, tooltip显示
;; (lazy-set-prefix-autoload-key sdcv-key-alist nil "C-c" "init-sdcv")
;;; ### Toolkit ###
;;; --- 工具函数
;; (lazy-load-set-keys
;;  '(
;;    ("s-c o" . one-key-menu-directory)  ;目录打开菜单
;;    ("s-," . bury-buffer)               ;隐藏当前buffer
;;    ("s-." . unbury-buffer)             ;反隐藏当前buffer
;;    ("s-[" . eval-expression)           ;执行表达式
;;    ("C-s-q" . quoted-insert)           ;读取系一个输入字符并插入
;;    ("M-h" . set-mark-command)          ;Instead C-Space for Chinese input method
;;    ("M-H" . set-mark-command)          ;Instead C-Space for Chinese input method
;;    ("<f9>" . lazycat-theme-toggle)
;;    ))
;; (lazy-load-global-keys
;;  '(
;;    ("s-R" . re-builder)                 ;可视化构建正则表达式
;;    )
;;  "init-rebuilder")
;; (lazy-set-autoload-key
;;  '(
;;    ("s-*" . one-key-menu-backup-file)   ;备份资料
;;    )
;;  "init-shell-command")
;; (lazy-set-autoload-key
;;  '(
;;    ("s-R" . re-builder)                 ;可视化构建正则表达式
;;    )
;;  "init-rebuilder")
;; (lazy-set-autoload-key                  ;快速运行
;;  '(
;;    ("M-!" . quickrun))
;;  "quickrun")
;; ;;; ### Color-moccur ###
;; ;;; --- 增强的moccur
;; (lazy-set-autoload-key
;;  '(
;;    ("s-x v" . moccur-grep)              ;搜索当前目录下的文件
;;    )
;;  "init-moccur")
;; (lazy-set-autoload-key
;;  '(
;;    ("s-x g" . moccur-grep-pointer)      ;递归搜索当前目录下的文件
;;    ("s-x h" . moccur-grep-input)        ;手动递归搜索当前目录下的文件
;;    )
;;  "moccur-extension")
;; (lazy-set-autoload-key
;;  '(
;;    ("C-z l" . linum-mode)               ;行号模式切换
;;    ("M-g" . goto-line-with-feedback)    ;可视化条转行
;;    )
;;  "linum-extension")
;; Dash.
;; (lazy-load-global-keys
;;  '(("y" . dash-at-point)
;;    )
;;  "dash-at-point"
;;  "C-x"
;;  )
;;; ### Buffer Move ###
;;; --- 缓存移动
(lazy-load-set-keys
 '(
   ("C-z k" . beginning-of-buffer)      ;缓存开始
   ("C-z j" . end-of-buffer)            ;缓存结尾
   ("C-M-f" . forward-paragraph)        ;下一个段落
   ("C-M-b" . backward-paragraph)       ;上一个段落
   ("C-M-y" . backward-up-list)         ;向左跳出 LIST
   ("C-M-o" . up-list)                  ;向右跳出 LIST
   ("C-M-u" . backward-down-list)       ;向左跳进 LIST
   ("C-M-i" . down-list)                ;向右跳进 LIST
   ("C-M-a" . beginning-of-defun)       ;函数开头
   ("C-M-e" . end-of-defun)             ;函数末尾
   ))

(lazy-load-global-keys
 '(
   ("M-s" . symbol-overlay-put)         ;懒惰搜索
   ("s-n" . symbol-overlay-jump-next)
   ("s-p" . symbol-overlay-jump-prev)
   )
 "init-symbol-overlay")

 (lazy-set-autoload-key
  '(
    ("s-N" . move-text-down)      ;把光标所在的整行文字(或标记)下移一行
    ("s-P" . move-text-up)        ;把光标所在的整行文字(或标记)上移一行
    )
  "move-text")
;; ;;; ### Buffer Name ###
;; ;;; --- 缓存名字
;; (lazy-set-autoload-key
;;  '(
;;    ("s-c r" . rename-file-and-buffer)        ;更改当前文件的名字
;;    ("s-c g" . move-buffer-file)              ;更改当前文件的目录
;;    ("s-c n" . copy-buffer-file-name-as-kill) ;拷贝buffer名字
;;    ("C-M-;" . kill-other-window-buffer)      ;关闭其他窗口的buffer
;;    ("s-Q" . kill-current-mode-buffers) ;关闭与当前模式相同的所有buffers
;;    ("C-S-s-q" . kill-current-mode-buffers) ;关闭与当前模式相同的所有buffers
;;    ("s-q" . kill-current-mode-buffers-except-current) ;关闭当前模式所有buffers, 除了当前buffer
;;    )
;;  "buffer-extension")
;; ;;; ### Buffer Edit ###
;; ;;; --- 缓存编辑
(lazy-set-key
 '(
   ("M-N" . kill-syntax-backward+)         ;向后进行语法删除
   ("M-M" . kill-syntax-forward+)          ;向前进行语法删除
   ("C-:" . comment-or-uncomment-region+)  ;注释当前行
   ("C-s-n" . comment-dwim-next-line)      ;移动到上一行并注释
   ("C-s-p" . comment-dwim-prev-line)      ;移动到下一行并注释
   ("M-s-n" . comment-part-move-down)      ;向下移动注释
   ("M-s-p" . comment-part-move-up)        ;向上移动注释
   ("C-x C-x" . exchange-point-and-mark)   ;交换当前点和标记点
   ("M-o" . backward-delete-char-untabify) ;向前删除字符
   ;; ("M-z" . zap-to-char)                      ;向前删除到第一个相符的字符
   ;; ("C-M-z" . zap-back-to-char)               ;向后删除到第一个相符的字符
   ("C-/" . undo)                             ;撤销
   ("C-?" . redo)                             ;重做
   ("s-k" . kill-and-join-forward)            ;在缩进的行之间删除
   ("C-x u" . mark-line)                      ;选中整行
   ("C-M-S-h" . mark-paragraph)               ;选中段落
   ("C-S-o" . duplicate-line-or-region-above) ;向上复制当前行或区域
   ("C-S-l" . duplicate-line-or-region-below) ;向下复制当前行或区域
   ("C-S-s-o" . duplicate-line-above-comment) ;复制当前行到上一行, 并注释当前行
   ("C-S-s-l" . duplicate-line-below-comment) ;复制当前行到下一行, 并注释当前行
   ("M-SPC" . just-one-space)                 ;只有一个空格在光标处
   ))
;;; ### Rect ###
;; ;;; --- 矩形操作
;; (lazy-set-autoload-key
;;  '(
;;    ("s-M" . rm-set-mark)                ;矩形标记
;;    ("s-X" . rm-exchange-point-and-mark) ;矩形对角交换
;;    ("s-D" . rm-kill-region)             ;矩形删除
;;    ("s-S" . rm-kill-ring-save)          ;矩形保存
;;    ("s-Y" . yank-rectangle)             ;粘帖矩形
;;    ("s-O" . open-rectangle)            ;用空白填充矩形, 并向右移动文本
;;    ("s-C" . clear-rectangle)           ;清空矩形
;;    ("s-T" . string-rectangle)          ;用字符串替代矩形的每一行
;;    ("s-I" . string-insert-rectangle)   ;插入字符串在矩形的每一行
;;    ("s-F" . delete-whitespace-rectangle) ;删除矩形中空格
;;    ("s-\"" . copy-rectangle-to-register) ;拷贝矩形到寄存器
;;    ("s-:" . mark-rectangle-to-end)       ;标记矩形到行末
;;    )
;;  "rect-extension")
;;; ### Font ###
;;; --- 字体命令
(lazy-set-key
 '(
   ("s--" . text-scale-decrease)        ;减小字体大小
   ("s-=" . text-scale-increase)        ;增加字体大小
   ("M--" . text-scale-decrease-global) ;减少字体大小, 全局
   ("M-+" . text-scale-increase-global) ;增加字体大小, 全局
   ("M-=" . text-scale-default-global)  ;恢复字体大小, 全局
   ))
;;; ### Window Operation ###
;;; --- 窗口操作
(lazy-set-key
 '(
   ("C-c v" . split-window-vertically)   ;纵向分割窗口
   ("C-c h" . split-window-horizontally) ;横向分割窗口
   ("C-;" . kill-this-buffer)            ;关闭当前buffer
   ("C-x ;" . delete-other-windows)      ;关闭其它窗口
   ))
;;; ### Multi-Scratch
;; (lazy-set-autoload-key
;;  '(
;;    ("s-a" . multi-scratch-new)
;;    ("s-A" . multi-scratch-next)
;;    )
;;  "multi-scratch")
(lazy-set-autoload-key
 '(
   ("s-;" . one-key-menu-window-navigation) ;快速窗口导航
   )
 "init-window")
;; (lazy-set-autoload-key
;;  '(
;;    ("C-c V" . delete-other-windows-vertically+)   ;关闭上下的其他窗口
;;    ("C-c H" . delete-other-windows-horizontally+) ;关闭左右的其他窗口
;;    ("C-'" . delete-current-buffer-and-window) ;关闭当前buffer, 并关闭窗口
;;    ("C-\"" . delete-current-buffer-window)    ;删除当前buffer的窗口
;;    ("C-s-7" . select-next-window)             ;选择下一个窗口
;;    ("C-s-8" . select-prev-window)             ;选择上一个窗口
;;    ("M-s-o" . toggle-one-window)              ;切换一个窗口
;;    ("C-x O" . toggle-window-split)
;;    )
;;  "window-extension")
;; (lazy-set-autoload-key
;; ;;  '(
;; ;;    ("C-x o" . ace-window))
;; ;;  "ace-window")
;; ;;; ### Tabbar ###
;; ;;; --- 多标签浏览
;; (lazy-set-key
;;  '(
;;    ("M-7" . tabbar-backward-tab)              ;移动到后一个标签
;;    ("M-8" . tabbar-forward-tab)               ;移动到前一个标签
;;    ("M-9" . tabbar-backward-group)            ;移动到后一个标签组
;;    ("M-0" . tabbar-forward-group)             ;移动到前一个标签组
;;    ("<C-tab>" . tabbar-backward-tab)          ;移动到后一个标签
;;    ("<C-S-iso-lefttab>" . tabbar-forward-tab) ;移动到前一个标签
;;    ))
;; (lazy-set-autoload-key
;;  '(
;;    ("M-&" . tabbar-backward-tab-other-window) ;向前移动其他窗口的标签
;;    ("M-*" . tabbar-forward-tab-other-window)  ;向后移动其他窗口的标签
;;    ("M-s-7" . tabbar-select-beg-tab)          ;移动到最左边的标签
;;    ("M-s-8" . tabbar-select-end-tab)          ;移动到最右边的标签
;;    )
;;  "tabbar-extension")
;; (lazy-set-autoload-key
;;   '(
;;     ("C-S-s" . swiper))
;;   "swiper")                              ;super regex search
;; (lazy-set-autoload-key
;;  '(
;;    ("<f11>" . fullscreen-toggle)        ;全屏切换
;;    )
;;  "fullscreen")
(lazy-set-autoload-key
  '(
    ("<f7>" . one-key-menu-ui)           ;用户界面菜单
    )
  "init-one-key")
;; (lazy-set-autoload-key
;;  '(
;;    ("C-7" . find-define-back)           ;返回查找符号的定义之前的位置
;;    ("C-8" . find-define-go)             ;查找符号的定义
;;    ("C-9" . find-define-prompt)         ;手动输入查询的定义
;;    )
;;  "find-define")
;; ### Paredit ###
;;  --- 结构化编程
(lazy-unset-key
  '("M-J" "M-r" "M-s" "C-k" "M-;" "C-M-f" "C-M-b" "M-)" "C-b" "C-f" "Spc-s")
  paredit-mode-map)                      ;卸载按键
 (defvar paredit-key-alist nil)
 (setq paredit-key-alist
        '(
          ;; 符号插入
          ("(" . paredit-open-parenthesis)       ;智能 (
          (")" . paredit-close-parenthesis)      ;智能 )
          ("[" . paredit-open-bracket)           ;智能 [
          ("]" . paredit-close-bracket)          ;智能 ]
          ("{" . paredit-open-curly)       ;智能 {
          ("}" . paredit-close-curly)            ;智能 }
          ("C-s-," . paredit-open-angled)        ;智能 <
          ("C-s-." . paredit-close-angled)       ;智能 >
          ("\"" . paredit-doublequote)           ;智能 "
          ("\\" . paredit-backslash)             ;智能 \
          ;; 删除
          ("M-o" . paredit-backward-delete)      ;向后删除
          ("C-d" . paredit-forward-delete)       ;向前删除
          ("C-M-m" . paredit-forward-kill-word)  ;向前按词删除
          ("C-M-n" . paredit-backward-kill-word) ;向后按词删除
          ;; 移动
         ("C-f" . paredit-forward)       ;向前移动
          ("C-b" . paredit-backward)      ;向后移动
          ;; 包围
          ("M-\"" . paredit-meta-doublequote) ;用 " " 包围对象, 或跳出字符串
          ("M-[" . paredit-wrap-square)       ;用 [ ] 包围对象
          ("M-{" . paredit-wrap-curly)        ;用 { } 包围对象
          ("C-(" . paredit-wrap-angled)       ;用 < > 包围对象
          ;; 跳出并换行缩进
          ("M-}" . paredit-close-curly-and-newline)  ;跳出 { } 并换行
          ("M-]" . paredit-close-square-and-newline) ;跳出 [ ] 并换行
          ;; ("C-)" . paredit-close-angled-and-newline)
                                        ;跳出 < > 并换行
          ;; 其他
         ("C-j" . paredit-newline)        ;智能换行并缩进
          ("M-q" . paredit-reindent-defun) ;重新格式化函数
          ("M-s-r" . paredit-raise-sexp) ;提取表达式, 并删除同一等级的其他表达式
          ("M-s-b" . paredit-convolute-sexp) ;嵌套表达式
          ("M-s-'" . one-key-menu-paredit)   ;Paredit 菜单
          ))
(lazy-set-key paredit-key-alist paredit-mode-map)
 ;; (lazy-set-mode-autoload-key
 ;;  '(
 ;;    ("C-k" . paredit-kill+))             ;增强的 paredit-kill
 ;;  paredit-mode-map nil "paredit-extension")
 ;; (lazy-set-autoload-key
 ;;  '(
 ;;    ("C-M-:" . paredit-comment-list-and-newline) ;注释当前LIST并换行
 ;;    ("M-:" . paredit-close-round-and-newline+) ;跳出 ( ) 或 " " 并换行
 ;;    ("M-?" . paredit-forward-sexp-and-newline) ;移动到下一个表达式, 并换行
 ;;    ("M-(" . paredit-wrap-sexp)                ;用 ( ) 包围当前对象
 ;;    ("M-)" . paredit-splice-sexp+)      ;去除包围对象的括号, 并删除空行
 ;;    ("C-S-k" . paredit-duplicate-closest-sexp) ;复制光标处的语法块
 ;;    )
 ;;  "paredit-extension")
;; ;;; ### Thingh-edit ###
;; ;;; --- 增强式编辑当前光标的对象
;; (lazy-set-autoload-key
;;  '(
;;    ("M-s-h" . one-key-menu-thing-edit)  ;thing-edit 菜单
;;    )
;;  "init-thing-edit"
;;  )
;;; ### Multi-Term ###
;; ;;; --- 多标签式的shell
;; (lazy-set-autoload-key
;;  '(
;;    ("s-n" . multi-term)                      ;新建一个终端
;;    ("s-h" . multi-term-next)                 ;选择终端
;;    ("s-x s-x" . multi-term-dedicated-toggle) ;切换专注终端
;;    ("s-x s-c" . multi-term-dedicated-select) ;选择专注终端
;;    )
;;  "init-multiterm")
;; ;;; ### W3m ###
;; ;;; --- 网页浏览器
;; (lazy-set-autoload-key
;;  '(
;;    ("C-z C-z" . w3m)                    ;启动W3M
;;    ("s-W" . one-key-menu-w3m-search)    ;w3m 搜索菜单
;;    )
;;  "init-w3m")
;; (lazy-set-autoload-key
;;  '(
;;    ("C-z z" . w3m-startup-background)         ;启动W3M, 后台
;;    ("C-x C-z" . toggle-w3m-with-other-buffer) ;在W3M和buffer间切换
;;    )
;;  "w3m-extension")
;;; ### Dired ###
;;; --- Dired
;; (lazy-set-autoload-key
;;  '(
;;    ("<f8>" . dired-jump)
;;    ("C-x C-f" . find-file)
;;    )
;;  "init-dired")
;;; ### Helm ###
;;; --- 快速buffer切换
;; (lazy-set-autoload-key
;;  '(
;;    ("s-y" . helm-dwim)
;;    ("s-t" . helm-descbinds)
;;    )
;;  "init-helm")
;;; ### EAF ###
;; ;;; EAF
;; (lazy-set-autoload-key
;;  '(
;;    ("s-'" . eaf-open)
;;    ("s-/" . eaf-stop-process)
;;    )
;;  "~/emacs-application-framework/eaf.el")
;; ;; Cycle buffer
;; (lazy-set-autoload-key
;;  '(
;;    ("M-C" . one-key-menu-cycle-buffer)  ;特定模式切换
;;    )
;;  "init-cycle-buffer")
;;; ### Isearch ###
;;; --- 交互式搜索
(lazy-unset-key                         ;全局按键的卸载
 '("C-s" "M-o"))
(lazy-set-key
 '(
   ("TAB" . isearch-complete)           ;isearch补全
   ("C-s" . isearch-repeat-forward) ;重复向前搜索, 第一次可以用来搜索上一次的历史哟
   ("C-r" . isearch-repeat-backward)   ;重复向后搜索
   ("C-g" . isearch-abort)             ;中止搜索
   ("C-w" . isearch-yank-word-or-char) ;粘帖光标后的词或字符作为搜索对象
   ("C-y" . isearch-yank-line)         ;粘帖光标后的行作为搜索对象
   ("M-o" . isearch-delete-char)       ;删除
   ("M-p" . isearch-ring-retreat)      ;搜索历史向后
   ("M-n" . isearch-ring-adjust)       ;搜索历史向前
   ("M-y" . isearch-yank-kill) ;从 kill ring 中粘帖最后一项到搜索对象后
   ("M-h" . isearch-yank-char) ;粘帖光标后的字符到搜索对象
   ("M-e" . isearch-edit-string)        ;编辑搜索对象
   ("M-c" . isearch-toggle-case-fold)   ;切换大小写
   ("M-r" . isearch-toggle-regexp)      ;切换正则表达式
   ("M-w" . isearch-toggle-word)        ;切换词
   ("M-g" . isearch-moccur)             ;moccur 当前 buffer
   ("M-G" . isearch-moccur-all)         ;moccur 所有 buffer
   ("M->" . isearch-beginning-of-buffer) ;跳转到buffer开头并重新搜索, 搜索最前面一个
   ("M-<" . isearch-end-of-buffer) ;跳转到buffer末尾并重新搜索, 搜索最后面一个
   ("M-%" . isearch-query-replace) ;替换
   ("M-d" . isearch-find-duplicate-word)    ;查找重复的单词
   ("M-z" . isearch-find-duplicate-line)    ;查找重复的行
   ("C-M-%" . isearch-query-replace-regexp) ;正则表达式替换
   )
 isearch-mode-map
 )

;; (lazy-set-autoload-key
;;  '(
;;    ("M-L" . isearch-to-lazy-search)     ;切换到lazy-search
;;    )
;;  "lazy-search-extension")
;;; ### Help ###
;; ;;; --- 帮助模式
;; (eval-after-load 'help-mode
;;   '(progn
;;      (lazy-set-key
;;       '(
;;         ("J" . scroll-up-one-line)      ;向下滚动一行
;;         ("K" . scroll-down-one-line)    ;向上滚动一行
;;         ("H" . describe-mode)           ;帮助
;;         ("f" . help-go-forward)         ;前一个帮助
;;         ("b" . help-go-back)            ;后一个帮助
;;         ("y" . sdcv-search-pointer+)    ;翻译
;;         ("<tab>" . forward-button)      ;前一个按钮
;;         )
;;       help-mode-map)
;;      (lazy-set-key vi-move-key-alist help-mode-map)
;;      ))
;; (add-hook 'package-menu-mode-hook
;;           '(lambda () (lazy-set-key vi-move-key-alist package-menu-mode-map)))
;; ;;; ### Helm Packman ###
;; ;;; --- Pacman 管理工具
;; (lazy-set-autoload-key
;;  '(
;;    ("s-x z" . helm-system-packages)
;;    )
;;  "helm-system-packages-pacman")
;; ;;; ### Flycheck ###
;; ;;; --- 及时拼写检查
;; (lazy-set-autoload-key
;;  '(
;;    ("M-s-j" . flycheck-next-error)      ;显示下一个错误
;;    ("M-s-k" . flycheck-previous-error)  ;显示上一个错误
;;    )
;;  "init-flycheck"
;;  )
;;; ### kill-ring-search ###
;; ;;; --- 删除环的递增式搜索
;; (lazy-set-autoload-key
;;  '(
;;    ("M-s-y" . kill-ring-search)         ;kill ring 搜索
;;    )
;;  "init-kill-ring-search")
;; ;;; ### Help ###
;; ;;; --- 帮助模式
;; (lazy-set-autoload-key
;;  '(
;;    ("C-h". one-key-menu-help)           ;帮助菜单
;;    )
;;  "init-help-mode")
;; ;;; ### IRC ###
;; ;;; --- 聊天
;; (lazy-set-autoload-key
;;  '(
;;    ("M-U" . one-key-menu-irc-channel)   ;跳转到IRC频道
;;    )
;;  "init-irc")
;; ;;; ### Yoaddmuse ###
;; ;;; --- Yet another oddmuse mode
;; (lazy-set-autoload-key
;;  '(
;;    ("M-s-;" . one-key-menu-yaoddmuse)   ;yaoddmuse 菜单
;;    )
;;  "init-yaoddmuse")
;; ;;; ### Festival ###
;; ;;; --- 语音阅读
;; (lazy-set-autoload-key
;;  '(
;;    ("s-x r" . one-key-menu-festival)    ;语音阅读菜单
;;    )
;;  "init-festival")
;; ;;; ### Less ###
;; ;;; --- 快速浏览模式
;; (lazy-set-autoload-key
;;  '(
;;    ("M-s-l" . less-minor-mode)          ;打开less模式
;;    )
;;  "init-less")
;; ;;; ### Speedbar ###
;; ;;; --- 快速访问文件和tags
;; (lazy-set-autoload-key
;;  '(
;;    ("s-z s-z" . sr-speedbar-toggle)        ;显示/隐藏speedbar
;;    ("s-z s-x" . sr-speedbar-select-window) ;选中speedbar窗口
;;    )
;;  "init-speedbar")
;; ### Multiple-cursors ###
;;; --- Multiple cursors, awesome
(require 'multiple-cursors)
(lazy-set-autoload-key
 '(
   ("s-o" . mc/mark-all-dwim)
   ("s-j" . mc/mark-next-like-this)
   ("s-k" . mc/mark-previous-like-this)
   ("s-u" . mc/unmark-next-like-this)
   ("s-i" . mc/unmark-previous-like-this)
   ("s-Z" . mc/edit-lines)
   )
 "multiple-cursors"
 )

;;pyim
(lazy-set-autoload-key
 '(
   ("C-S-p" . pyim-convert-code-at-point)
   )
 "pyim"
 )

;; ### Ace jump ###
(lazy-set-autoload-key
 '(
   ("s-<" . ace-jump-word-mode)
   ("s->" . ace-jump-char-mode)
   ("s-?" . ace-jump-line-mode)
   )
 "ace-jump-mode")
;; ### Python ###
;;; --- Python mode
(eval-after-load 'python-mode
  '(lambda ()
     (lazy-set-mode-autoload-key
      '(
        ("C-S-j" . jump-to-import)
        )
      python-mode-map nil "python-mode-utils")
     ))
;;; ### Ielm ###
;; ;;; --- Emacs Lisp 解释模式
;; (autoload 'ielm-map "ielm")
;; (lazy-set-autoload-key
;;  '(
;;    ("M-s-i" . ielm-toggle)              ;切换ielm
;;    ("s-6" . insert-standard-date)       ;插入标准时间
;;    ("s-7" . insert-changelog-date)      ;插入Changlog时间
;;    )
;;  "lazycat-toolkit")
;; (eval-after-load 'ielm-mode
;;   '(lambda ()
;;      (progn
;;        (lazy-unset-key
;;         '("M-p" "M-n")
;;         ielm-map)                       ;卸载按键
;;        (lazy-set-key
;;         '(
;;           ("C-s-p" . comint-previous-input) ;上一个输入
;;           ("C-s-n" . comint-next-input)     ;下一个输入
;;           )
;;         ielm-map
;;         )
;;        )))
;; ;;; ### Man ###
;; ;;; --- Man
;; (lazy-set-autoload-key
;;  '(
;;    ("C-<f1>" . woman))
;;  "init-woman")
;; ;;; ### Company en words ###
;; ;;; --- 英文助手
;; (lazy-set-autoload-key
;;  '(
;;    ("M-r" . toggle-company-english-helper) ;英文助手
;;    )
;;  "company-english-helper")
;; ;;; ### Ispell ###
;; ;;; --- 拼写检查
(lazy-set-autoload-key
 '(("s-v s-v" . ispell-buffer))
 "init-ispell")                         ;检查当前buffer
;;; ### Ido ###
;; ;;; --- 交互式管理文件和缓存
;; (lazy-set-key
;;  '(
;;    ("C-x C-f" . ido-find-file)          ;交互式查找文件
;;    ("C-x b" . ido-switch-buffer)        ;交互式切换buffer
;;    ("C-x i" . ido-insert-buffer)        ;插入缓存
;;    ("C-x I" . ido-insert-file)          ;插入文件
;;    ))
;; (add-hook 'ido-setup-hook
;;           '(lambda ()
;;              (interactive)
;;              (ido-my-keys ido-completion-map)))
;; (defun ido-my-keys (keymap)
;;   "Add my keybindings for ido."
;;   (lazy-set-key
;;    '(
;;      ("M-s-p" . ido-prev-match)              ;上一个匹配
;;      ("M-s-n" . ido-next-match)              ;下一个匹配
;;      ("M-s-h" . ido-next-work-directory)     ;下一个工作目录
;;      ("M-s-l" . ido-prev-work-directory)     ;上一个工作目录
;;      ("M-o" . backward-delete-char-untabify) ;向前删除字符
;;      ("M-O" . ido-delete-backward-updir)     ;删除字符或进入上一级目录
;;      )
;;    keymap
;;    ))
;; ;;; ### IRC ###
;; ;;; --- 聊天
;; (lazy-set-autoload-key
;;  '(
;;    ("C-c i" . switch-to-erc)            ;切换到IRC或自动登录IRC
;;    ("C-c I" . erc-nick-notify-jump-last-channel) ;自动跳转到最后收到消息的频道
;;    ("M-U" . one-key-menu-irc-channel)            ;跳转到IRC频道
;;    )
;;  "init-erc")
;; ;;; Elisp
;; (lazy-set-key
;;  '(
;;    ("RET" . comment-indent-new-line)    ;自动换行并注释
;;    )
;;  emacs-lisp-mode-map
;;  )
;; ;;; ### Wget ###
;; ;;; --- 下载程序
;; (lazy-set-autoload-key
;;  '(
;;    ("s-c dd" . wget-show)               ;显示下载信息
;;    ("s-c dh" . wget-hide)               ;隐藏下载信息
;;    ("s-c dq" . wget-quit-and-exit)      ;停止下载
;;    )
;;  "wget-extension")
;; ;;; ### Org ###
;; ;;; --- 笔记管理和组织
;; (lazy-set-autoload-key
;;  '(
;;    ("s-s" . one-key-menu-org-file)      ;Org 文件
;;    ("C-c r" . org-remember)             ;Org-remeber
;;    )
;;  "init-org-mode")
;; ;;; ### String Inflection ###
;; ;; --- 单词语法风格快速转换
;; (lazy-set-autoload-key
;;  '(
;;    ("C-c C-u" . one-key-string-inflection)
;;    )
;;  "init-string-inflection")
;; ;;; ### Projectile Rails ###
;; ;; Rails 文件快速导航
;; (lazy-set-autoload-key
;;  '(
;;    ("s-c p" . one-key-projectile-rails) ;projectile rails
;;    )
;;  "init-projectile-rails")
;; ;;; ### Top ###
;; ;;; --- 进程管理器
;; (lazy-set-autoload-key
;;  '(
;;    ("<s-f8>" . top)                     ;TOP
;;    )
;;  "init-top")
;; ;;; ### Doc-view ###
;; ;;; --- 文档阅读器
;; (lazy-set-autoload-key
;;  '(
;;    ("C-M-j" . pdf-view-scroll-up-or-next-page+) ;翻另一个窗口中图书的下一页
;;    ("C-M-k" . pdf-view-scroll-down-or-previous-page+) ;翻另一个窗口中图书的上一页
;;    )
;;  "init-pdf-tools")
;; ;;; ### Keyboard Macro ###
;; ;;; --- 键盘宏
;; (lazy-set-autoload-key
;;  '(
;;    ("M-s-s" . kmacro-start-macro-or-insert-counter) ;开始键盘宏或插入
;;    ("M-s-d" . kmacro-end-or-call-macro)             ;结束键盘宏或调用
;;    ("M-s-c" . kmacro-delete-ring-head)              ;删除当前的键盘宏
;;    ("M-s-w" . kmacro-cycle-ring-next)               ;下一个键盘宏
;;    ("M-s-e" . kmacro-cycle-ring-previous)           ;上一个键盘宏
;;    ("M-s-a" . kmacro-edit-macro)                    ;编辑键盘宏
;;    ("M-s-v" . name-last-kbd-macro)                  ;命令当前键盘宏
;;    ("M-s-f" . insert-kbd-macro)                     ;插入键盘宏
;;    ("M-s-q" . apply-macro-to-region-lines) ;应用键盘宏到选择的区域
;;    )
;;  "macros+")
;; ;;; ### auto-install ###
;; (lazy-set-autoload-key
;;  '(
;;    ("C-s-x" . auto-install-from-emacswiki))
;;  "init-auto-install")
;; ;;; ### expand-region ###
;; (lazy-set-autoload-key
;;  '(
;;    ("C-=" . er/expand-region))
;;  "expand-region")
;; ### vdiff ###
(lazy-set-autoload-key
 '(
   ("M-s-u" . vdiff-buffers))
 "vdiff")




(provide 'init-key)
