;; awesome-tray
(add-to-list 'load-path "~/.spacemacs.d/private/awesome-tray")
(require 'awesome-tray)
(awesome-tray-mode 1)
;; 在终端里使用，需要加入以下代码，可以压缩modeline 厚度
;; (if (display-graphic-p)
;;        (setq-default mode-line-format '(" "))
;;      (setq-default mode-line-format nil))

(defun awesome-tray-module-input-method-info ()
  (pcase current-input-method
    ('nil "EN")
    ("pyim" "ZN")
    ("japanese" "JA")))

(defun awesome-tray-read-only ()
  (if (eq buffer-read-only t)
      "read-only"
    ""))

(defun awesome-tray-buffer-modified ()
  (if (buffer-modified-p)
      "*"
    ""))

(defun awesome-tray-netease-current-song ()
  (when (netease-cloud-music-process-live-p)
    (format "%s-%s"
            (car netease-cloud-music-current-song)
            (nth 1 netease-cloud-music-current-song))))

(add-to-list 'awesome-tray-module-alist '("buffer-read-only" . (awesome-tray-read-only awesome-tray-module-parent-dir-face)))
(add-to-list 'awesome-tray-module-alist '("buffer-modified-p" . (awesome-tray-buffer-modified awesome-tray-module-date-face)))
(add-to-list 'awesome-tray-module-alist '("netease-current-song" . (awesome-tray-netease-current-song awesome-tray-module-mode-name-face)))

(setq awesome-tray-active-modules '("sniem-state" "input-method" "location" "buffer-read-only"
                                    "buffer-modified-p" "git" "mode-name" "date"))

(provide 'init-awesome-tray)
