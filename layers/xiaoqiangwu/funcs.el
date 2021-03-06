(defun xiaoqiangwu/load-my-layout ()
  (interactive)
  (persp-load-state-from-file (concat persp-save-dir "wuxiaoqiang")))

(defun xiaoqiangwu/save-my-layout ()
  (interactive)
  (persp-save-state-to-file (concat persp-save-dir "wuxiaoqiang")))

;; invoke
(global-set-key [f8] 'gdb)

;; GDB layout
(defadvice gdb-setup-windows (after activate)
  (gdb-setup-my-windows)
)

(defun gdb-setup-my-windows ()
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (let
    ((win0 (selected-window))             ; source
     (win1 (split-window-horizontally
             (floor (* 0.5 (window-width)))))   ; gdb
     (win2 (split-window-vertically
             (floor (* 0.7 (window-body-height))))) ; bp
    )
    ;; set source buffer
    (set-window-buffer
     win0
     (if gud-last-last-frame
         (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
           (gud-find-file gdb-main-file)
         (list-buffers-noselect))))
    (setq gdb-source-window win0)

    (select-window win1)
    (split-window-vertically (floor (* 0.7 (window-body-height))))
    (split-window-horizontally (floor (* 0.7 (window-body-width))))
    (split-window-vertically (floor (* 0.4 (window-body-height))))

    ;; set locals window
    (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-locals-buffer))
    ;; set assembly window
    (other-window 1)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (other-window 1)
    (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-registers-buffer))
    ;; set breakpoint buffer
    (other-window 1)
    (gdb-set-window-buffer (gdb-breakpoints-buffer-name))
    ;; set focus on gdb buffer
    (select-window win2)
  )
)

;; GDB variables
(setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gdb-show-changed-values t)
(setq gdb-use-colon-colon-notation t)
(setq gdb-use-separate-io-buffer nil)
;; (setq gdb-delete-out-of-scope t)
(setq gud-tooltip-display t)
(setq gdb-speedbar-auto-raise t)

(defadvice gud-display-line (after gud-display-line-centered activate)
  "Center the line in the window"
  (when (and gud-overlay-arrow-position gdb-source-window)
    (with-selected-window gdb-source-window
     ;; (marker-buffer gud-overlay-arrow-position)
      (save-restriction
        (goto-line (ad-get-arg 1))
        (recenter)))))

;; GDB highlight current line
(set-face-foreground 'secondary-selection "black")
(set-face-background 'secondary-selection "green")
(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
    (overlay-put ov 'face 'secondary-selection)
    ov)
  "Overlay variable for GUD highlighting.")
(defadvice gud-display-line (after my-gud-highlight act)
  "Highlight current line."
  (let* ((ov gud-overlay)
         (bf (gud-find-file true-file)))
    (with-current-buffer bf
      (move-overlay ov (line-beginning-position)
                       (line-beginning-position 2)
                       (current-buffer)))))
(defun gud-kill-buffer ()
  (if (derived-mode-p 'gud-mode)
      (delete-overlay gud-overlay)))
(add-hook 'kill-buffer-hook 'gud-kill-buffer)

(defun toggle-window-dedicated ()
  "Control whether or not Emacs is allowed to display another
buffer in current window."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "%s: Can't touch this!"
     "%s is up for grabs.")
   (current-buffer)))

(global-set-key (kbd "C-x t") 'toggle-window-dedicated)

;; org mode functions
(defun get-year-and-month ()
  (list (format-time-string "%Y") (format-time-string "%m")))

(defun find-month-tree ()
  (let* ((path (get-year-and-month))
         (level 1)
         end)
    (unless (derived-mode-p 'org-mode)
      (error "Target buffer \"%s\" should be in Org mode" (current-buffer)))
    (goto-char (point-min))             ;移动到 buffer 的开始位置
    ;; 先定位表示年份的 headline，再定位表示月份的 headline
    (dolist (heading path)
      (let ((re (format org-complex-heading-regexp-format
                        (regexp-quote heading)))
            (cnt 0))
        (if (re-search-forward re end t)
            (goto-char (point-at-bol))  ;如果找到了 headline 就移动到对应的位置
          (progn                        ;否则就新建一个 headline
            (or (bolp) (insert "\n"))
            (if (/= (point) (point-min)) (org-end-of-subtree t t))
            (insert (make-string level ?*) " " heading "\n"))))
      (setq level (1+ level))
      (setq end (save-excursion (org-end-of-subtree t t))))
    (org-end-of-subtree)))
