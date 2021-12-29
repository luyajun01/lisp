;; -*- coding: utf-8; lexical-binding: t; -*-

;; some cool org tricks
;; @see http://emacs.stackexchange.com/questions/13820/inline-verbatim-and-code-with-quotes-in-org-mode


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;org-src
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'init-custom)
(defun icons-displayable-p ()
  "Return non-nil if `all-the-icons' is displayable."
  (and centaur-icon
       (display-graphic-p)
       (require 'all-the-icons nil t)))

(use-package pretty-hydra
  :bind ("<f6>" . toggles-hydra/body)
  :init
  (cl-defun pretty-hydra-title (title &optional icon-type icon-name
                                      &key face height v-adjust)
    "Add an icon in the hydra title."
    (let ((face (or face `(:foreground ,(face-background 'highlight))))
          (height (or height 1.0))
          (v-adjust (or v-adjust 0.0)))
      (concat
       (when (and (icons-displayable-p) icon-type icon-name)
         (let ((f (intern (format "all-the-icons-%s" icon-type))))
           (when (fboundp f)
             (concat
              (apply f (list icon-name :face face :height height :v-adjust v-adjust))
              " "))))
       (propertize title 'face face)))))

(use-package org
  :ensure nil
  :custom-face (org-ellipsis ((t (:foreground nil))))
  :preface
  (defun hot-expand (str &optional mod)
    "Expand org template.
STR is a structure template string recognised by org like <s. MOD is a
string with additional parameters to add the begin line of the
structure element. HEADER string includes more parameters that are
prepended to the element after the #+HEADER: tag."
    (let (text)
      (when (region-active-p)
        (setq text (buffer-substring (region-beginning) (region-end)))
        (delete-region (region-beginning) (region-end)))
      (insert str)
      (if (fboundp 'org-try-structure-completion)
          (org-try-structure-completion) ; < org 9
        (progn
          ;; New template expansion since org 9
          (require 'org-tempo nil t)
          (org-tempo-complete-tag)))
      (when mod (insert mod) (forward-line))
      (when text (insert text))))
  :pretty-hydra
  ((:title (pretty-hydra-title "Org Template" 'fileicon "org" :face 'all-the-icons-green :height 1.1 :v-adjust 0.0)
    :color blue :quit-key "q")
   ("Basic"
    (("a" (hot-expand "<a") "ascii")
     ;; ("c" (hot-expand "<c") "center")
     ;; ("c" (hot-expand "<s" "c++") "c++")
     ("C" (hot-expand "<C") "comment")
     ("e" (hot-expand "<e") "example")
     ("E" (hot-expand "<E") "export")
     ("h" (hot-expand "<h") "html")
     ("l" (hot-expand "<l") "latex")
     ("n" (hot-expand "<n") "note")
     ("o" (hot-expand "<q") "quote")
     ("v" (hot-expand "<v") "verse"))
    "Head"
    (("i" (hot-expand "<i") "index")
     ("A" (hot-expand "<A") "ASCII")
     ("I" (hot-expand "<I") "INCLUDE")
     ("H" (hot-expand "<H") "HTML")
     ("L" (hot-expand "<L") "LaTeX"))
    "Source"
    (("s" (hot-expand "<s") "src")
     ("c" (hot-expand "<s" "c++") "c++")
     ("m" (hot-expand "<s" "emacs-lisp") "emacs-lisp")
     ("p" (hot-expand "<s" "python :results output") "python")
     ;; ("p" (hot-expand "<s" "perl") "perl")
     ("r" (hot-expand "<s" "R") "R")
          ;; ("r" (hot-expand "<s" "ruby") "ruby")
     ("S" (hot-expand "<s" "sh") "sh")
     ("g" (hot-expand "<s" "go :imports '\(\"fmt\"\)") "golang"))
    "Misc"
    (("u" (hot-expand "<s" "plantuml :file CHANGE.png") "plantuml")
     ("Y" (hot-expand "<s" "ipython :session :exports both :results raw drawer\n$0") "ipython")
     ("P" (progn
            (insert "#+HEADERS: :results output :exports both :shebang \"#!/usr/bin/env perl\"\n")
            (hot-expand "<s" "perl")) "Perl tangled")
     ("<" self-insert-command "ins"))))

    :bind (("C-c a" . org-agenda)
         ("C-c b" . org-switchb)
         :map org-mode-map
         ("<" . (lambda ()
                  "Insert org template."
                  (interactive)
                  (if (or (region-active-p) (looking-back "^\s*" 1))
                      (org-hydra/body)
                    (self-insert-command 1)))))
  :hook ((org-mode . (lambda ()
                       "Beautify org symbols."
                       (setq prettify-symbols-alist centaur-prettify-org-symbols-alist)
                       (prettify-symbols-mode 1)))
         (org-mode . auto-fill-mode)
         (org-indent-mode . (lambda()
                              (diminish 'org-indent-mode)
                              ;; WORKAROUND: Prevent text moving around while using brackets
                              ;; @see https://github.com/seagle0128/.emacs.d/issues/88
                              (make-variable-buffer-local 'show-paren-mode)
                              (setq show-paren-mode nil))))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'org-clock
  ;; Change task state to STARTED when clocking in
  (setq org-clock-in-switch-to-state "STARTED")
  ;; Save clock data and notes in the LOGBOOK drawer
  (setq org-clock-into-drawer t)
  ;; Removes clocked tasks with 0:00 duration
  (setq org-clock-out-remove-zero-time-clocks t)

  ;; Show the clocked-in task - if any - in the header line
  (defun sanityinc/show-org-clock-in-header-line ()
    (setq-default header-line-format '((" " org-mode-line-string " "))))

  (defun sanityinc/hide-org-clock-from-header-line ()
    (setq-default header-line-format nil))

  (add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
  (add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
  (add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

  (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu))

;; {{ org2nikola set up
(setq org2nikola-output-root-directory "~/.config/nikola")
;; }}

(defun org-demote-or-promote (&optional is-promote)
  "Demote or promote current org tree."
  (interactive "P")
  (save-excursion
    (beginning-of-line)
    (unless (or (region-active-p)
                (let ((line (thing-at-point 'line t)))
                  (and (string-match-p "^\\*+ $" line) ;; is node only one spaced
                       (= (point) (- (point-max) (length line))) ;; is line at EOF
                       )))
      (org-mark-subtree)))
  (if is-promote (org-do-promote) (org-do-demote)))

;; {{ @see http://orgmode.org/worg/org-contrib/org-mime.html
(with-eval-after-load 'org-mime
  (setq org-mime-export-options '(:section-numbers nil :with-author nil :with-toc nil))
  (defun org-mime-html-hook-setup ()
    (org-mime-change-element-style "pre"
                                   "color:#E6E1DC; background-color:#232323; padding:0.5em;")
    (org-mime-change-element-style "blockquote"
                                   "border-left: 2px solid gray; padding-left: 4px;"))
  (add-hook 'org-mime-html-hook 'org-mime-html-hook-setup))
;; }}

(defun org-mode-hook-setup ()
  (unless (is-buffer-file-temp)
    (setq evil-auto-indent nil)

    ;; org-mime setup, run this command in org-file, than yank in `message-mode'
    (local-set-key (kbd "C-c M-o") 'org-mime-org-buffer-htmlize)

    ;; don't spell check double words
    (setq-local wucuo-flyspell-check-doublon nil)

    ;; create updated table of contents of org file
    ;; @see https://github.com/snosov1/toc-org
    (toc-org-enable)

    ;; default `org-indent-line' inserts extra spaces at the beginning of lines
    (setq-local indent-line-function 'indent-relative)

    ;; display wrapped lines instead of truncated lines
    (setq truncate-lines nil)
    (setq word-wrap t)))
(add-hook 'org-mode-hook 'org-mode-hook-setup)

(defvar my-pdf-view-from-history nil
  "PDF view FROM history which is List of (pdf-path . page-number).")

(defvar my-pdf-view-to-history nil
 "PDF view TO history which is List of (pdf-path . page-number).")

(with-eval-after-load 'org
  ;; {{
  (defvar my-org-src--saved-temp-window-config nil
    "Window layout before edit special element.")
  (defun my-org-edit-special (&optional arg)
    "Save current window layout before `org-edit' buffer is open.
ARG is ignored."
    (setq my-org-src--saved-temp-window-config (current-window-configuration)))

  (defun my-org-edit-src-exit ()
    "Restore the window layout that was saved before `org-edit-special' is called."
    (when my-org-src--saved-temp-window-config
      (set-window-configuration my-org-src--saved-temp-window-config)
      (setq my-org-src--saved-temp-window-config nil)))


  ;; org 9.3 do not restore windows layout when editing special element
  (advice-add 'org-edit-special :before 'my-org-edit-special)
  (advice-add 'org-edit-src-exit :after 'my-org-edit-src-exit)
  ;; }}

  (my-ensure 'org-clock)

  ;; org-re-reveal requires org 8.3
  (my-ensure 'org-re-reveal)

  ;; odt export
  (add-to-list 'org-export-backends 'odt)

  ;; markdown export
  (my-ensure 'ox-md)
  (add-to-list 'org-export-backends 'md)

  (defun org-agenda-show-agenda-and-todo (&optional arg)
    "Better org-mode agenda view."
    (interactive "P")
    (org-agenda arg "n"))


  (defun my-org-open-at-point-hack (orig-func &rest args)
    "\"C-u M-x org-open-at-point\" to open link with `browse-url-generic-program'.
It's value could be customized liked \"/usr/bin/firefox\".
\"M-x org-open-at-point\" to open the url with embedded emacs-w3m."
    (let* ((arg (nth 0 args))
           (reference-buffer (nth 1 args))
           (browse-url-browser-function
            (cond
             ;; open with `browse-url-generic-program'
             ((equal arg '(4)) 'browse-url-generic)
             ;; open with w3m
             (t 'w3m-browse-url))))
      (apply orig-func args)))
  (advice-add 'org-open-at-point :around #'my-org-open-at-point-hack)

  ;; {{ org pdf link
  (defun my-org-docview-open-hack (orig-func &rest args)
    (let* ((link (car args)) path page)
      (string-match "\\(.*?\\)\\(?:::\\([0-9]+\\)\\)?$" link)
      (setq path (match-string 1 link))
      (setq page (and (match-beginning 2)
                      (string-to-number (match-string 2 link))))

      ;; record FROM
      (my-focus-on-pdf-window-then-back
       (lambda (pdf-file)
         (when (and page (string= (file-name-base pdf-file) (file-name-base path)))
           ;; select pdf-window
           (when (and (memq major-mode '(doc-view-mode pdf-view-mode))
                      (setq pdf-from-page
                            (if (eq major-mode 'pdf-view-mode) (pdf-view-current-page) (doc-view-current-page)))
                      (> (abs (- page pdf-from-page)) 2))
             (my-push-if-uniq (format "%s:::%s" pdf-file pdf-from-page) my-pdf-view-from-history)))))
      ;; open pdf file
      (org-open-file path 1)
      (when page
        ;; record TO
        (my-push-if-uniq (format "%s:::%s" path page) my-pdf-view-to-history)
        ;; goto page
        (my-pdf-view-goto-page page))))
  (advice-add 'org-docview-open :around #'my-org-docview-open-hack)
  ;; }}

  (defun my-org-publish-hack (orig-func &rest args)
    "Stop running `major-mode' hook when `org-publish'."
    (let* ((my-load-user-customized-major-mode-hook nil))
      (apply orig-func args)))
  (advice-add 'org-publish :around #'my-org-publish-hack)

  ;; {{ convert to odt
  (defun my-setup-odt-org-convert-process ()
    (interactive)
    (let* ((cmd "/Applications/LibreOffice.app/Contents/MacOS/soffice"))
      (when (and *is-a-mac* (file-exists-p cmd))
        ;; org v8
        (setq org-odt-convert-processes
              '(("LibreOffice" "/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to %f%x --outdir %d %i"))))))
  (my-setup-odt-org-convert-process)
  ;; }}

  (defun my-org-refile-hack (orig-func &rest args)
    "When `org-refile' scans org files,
skip user's own code in `org-mode-hook'."
    (let* ((my-force-buffer-file-temp-p t))
      (apply orig-func args)))
  (advice-add 'org-refile :around #'my-org-refile-hack)

  ;; {{ export org-mode in Chinese into PDF
  ;; @see http://freizl.github.io/posts/tech/2012-04-06-export-orgmode-file-in-Chinese.html
  ;; and you need install texlive-xetex on different platforms
  ;; To install texlive-xetex:
  ;;    `sudo USE="cjk" emerge texlive-xetex` on Gentoo Linux
  (setq org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f")) ;; org v8
  ;; }}

  ;; misc
  (setq org-log-done t
        org-completion-use-ido t
        org-edit-src-content-indentation 0
        org-edit-timestamp-down-means-later t
        org-agenda-start-on-weekday nil
        org-agenda-span 14
        org-agenda-include-diary t
        org-agenda-window-setup 'current-window
        org-fast-tag-selection-single-key 'expert
        org-export-kill-product-buffer-when-displayed t
        ;; org-startup-indented t
        ;; {{ org 8.2.6 has some performance issue. Here is the workaround.
        ;; @see http://punchagan.muse-amuse.in/posts/how-i-learnt-to-use-emacs-profiler.html
        org-agenda-inhibit-startup t ;; ~50x speedup
        org-agenda-use-tag-inheritance nil ;; 3-4x speedup
        ;; }}
        ;; org v8
        org-odt-preferred-output-format "doc"
        org-tags-column 80

        ;; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
        org-refile-targets '((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-todo-keywords (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                                  (sequence "WAITING(w@/!)" "SOMEDAY(S)" "PROJECT(P@)" "|" "CANCELLED(c@/!)")))
        org-imenu-depth 9
        ;; @see http://irreal.org/blog/1
        org-src-fontify-natively t))

(provide 'init-org)
