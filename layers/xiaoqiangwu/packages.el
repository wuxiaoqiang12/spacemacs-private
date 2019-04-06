;;; packages.el --- xiaoqiangwu layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: jon <jon@jon-lab>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `xiaoqiangwu-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `xiaoqiangwu/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `xiaoqiangwu/pre-init-PACKAGE' and/or
;;   `xiaoqiangwu/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst xiaoqiangwu-packages
  '(proof-general
    company
    company-coq
    hungry-delete
    flycheck)
)


(defun xiaoqiangwu/init-proof-general()
  (use-package proof-general
    :ensure t
    :config))

(defun xiaoqiangwu/post-init-company()
  (setq company-minimum-prefix-length 1)
  (global-company-mode))

(defun xiaoqiangwu/init-company-coq()
  (use-package company-coq
    :ensure t
    :config
    (add-hook 'coq-mode-hook #'company-coq-mode)))

(defun xiaoqiangwu/post-init-hungry-delete()
  (global-hungry-delete-mode))

(defun xiaoqiangwu/post-init-flycheck()
  (add-hook 'coq-mode-hook 'flycheck-mode))
;;; packages.el ends here
