;; https://www.zmonster.me/2020/06/27/org-roam-introduction.html#org6fd36c4
(require 'org-roam)
(require 'org-roam-server)
(require 'org-roam-protocol)

(setq org-roam-directory "~/Documents/坚果云/我的坚果云/github/wiki")

(setq org-roam-server-host "127.0.0.1"
      org-roam-server-port 9090
      org-roam-server-export-inline-images t
      org-roam-server-authenticate nil
      org-roam-server-label-truncate t
      org-roam-server-label-truncate-length 60
      org-roam-server-label-wrap-length 20)
(org-roam-server-mode)

(add-hook 'after-init-hook 'org-roam-mode)

(setq org-roam-capture-templates
      '(
        ("d" "default" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_alias:\n\n")
        ("g" "group")
        ("ga" "Group A" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_alias:\n\n")
        ("gb" "Group B" plain (function org-roam-capture--get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n")))
(add-to-list 'org-roam-capture-templates
             '("t" "Term" plain (function org-roam-capture--get-point)
               "- 领域: %^{术语所属领域}\n- 释义:"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n"
               :unnarrowed t
               ))
(add-to-list 'org-roam-capture-templates
             '("p" "Paper Note" plain (function org-roam-capture--get-point)
               "* 相关工作\n\n%?\n* 观点\n\n* 模型和方法\n\n* 实验\n\n* 结论\n"
               :file-name "%<%Y%m%d%H%M%S>-${slug}"
               :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags: \n\n"
               :unnarrowed t
               ))

;; ;; org-roam-insert-immediate 不使用 org-roam-capture-templates，
;; ;; 而是使用一个专门的 org-roam-capture-immediate-template 来设置新建内容的模板，
;; ;; 且只能有一个模板，所以设置这个模板的配置是这样的（以默认配置为例）
;; (setq org-roam-capture-immediate-template
;;       '("d" "default" plain (function org-roam-capture--get-point)
;;         "%?"
;;         :file-name "%<%Y%m%d%H%M%S>-${slug}"
;;         :head "#+title: ${title}\n"
;;         :unnarrowed t))

;; ;; org-roam 中可以通过 org-roam-capture-ref-templates 来设置网页捕获相关的模板，默认的设置是这样的
(setq org-roam-capture-ref-templates
      '(("r" "ref" plain (function org-roam-capture--get-point)
         ""
         :file-name "${slug}"
         :head "#+title: ${title}\n#+roam_key: ${ref}\n"
         :unnarrowed t)))

(add-to-list 'org-roam-capture-ref-templates
             '("a" "Annotation" plain (function org-roam-capture--get-point)
               "%U ${body}\n"
               :file-name "${slug}"
               :head "#+title: ${title}\n#+roam_key: ${ref}\n#+roam_alias:\n"
               :immediate-finish t
               :unnarrowed t))

(use-package org-roam
  :ensure t
  :diminish org-roam-mode
  :hook
  (after-init . org-roam-mode)
  :commands (org-roam-build-cache)
  ;; :straight (:host github :repo "jethrokuan/org-roam" :branch "master")
  :config
  (progn
    (require 'org-roam-protocol)
    (setq org-roam-directory "~/Documents/org/")
    (setq org-roam-file-extensions '("org" "txt"))
    (setq org-roam-index-file "index.org")
    (setq org-roam-graph-extra-config '(("overlap" . "prism")
                                        ("color" . "skyblue"))
          org-roam-graph-exclude-matcher "private")
    (setq org-roam-capture-templates
          '(("d" "default" plain
             #'org-roam-capture--get-point
             :file-name "%<%Y-%m-%d>-${slug}"
             :head "#+title: ${title}\n#+ROAM_TAGS: %^{org-roam-tags}\n#+created: %u\n#+last_modified: %U\n%?"
             :unnarrowed t
             :jump-to-captured t)
            ("p" "private" plain
             #'org-roam-capture--get-point
             :file-name "private/${slug}"
             :head "#+title: ${title}\n#+ROAM_TAGS: %^{org-roam-tags}\n#+created: %u\n#+last_modified: %U\n%?"
             :unnarrowed t
             :jump-to-captured t)))

    "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
    (defhydra hydra-roam (:color teal
                                 :hint nil)
      "
  _f_:ind file  _i_:nsert  _I_:ndex  _g_:raph
  _c_:apture  _s_:erver    _r_:oam  rando:_m_
  _b_:uffer
  "
      ("q" nil "quit")
      ("r" org-roam)
      ("f" org-roam-find-file)
      ("i" org-roam-insert)
      ("I" org-roam-jump-to-index)
      ("g" org-roam-graph)
      ("c" org-roam-capture)
      ("m" org-roam-random-note)
      ("s" org-roam-server-mode)
      ("b" org-roam-switch-to-buffer))
    (setq org-roam-buffer-position 'right))

  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           #'org-roam-capture--get-point
           "* %?"
           :file-name "daily/%<%Y-%m-%d>"
           :head "#+title: %<%Y-%m-%d>\n\n")))

  :custom-face
  (org-roam-link ((t (:inherit org-link :foreground "#C991E1")))))


(use-package company-org-roam
  ;; :straight (:host github :repo "jethrokuan/company-org-roam")
  :config
  (push 'company-org-roam company-backends))


(provide 'init-org-roam)
