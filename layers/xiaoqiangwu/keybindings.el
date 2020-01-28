;;; keybindings.el --- Better Emacs Defaults Layer key bindings File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
(global-set-key (kbd "M-s o") 'occur-dwim)
(spacemacs/set-leader-keys "oll" 'xiaoqiangwu/load-my-layout)
(spacemacs/set-leader-keys "ols" 'xiaoqiangwu/save-my-layout)
(global-set-key (kbd "M-.") 'ggtags-find-definition)
(global-set-key (kbd "M-,") 'ggtags-prev-mark)
(spacemacs/set-leader-keys "ov" 'evil-visual-block)
(global-set-key [f5] 'treemacs-projectile)
;;(global-set-key (kbd "C-p s g") 'projectile-grep)
;;(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;;(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;;(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;;(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;;(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;;(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;;(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)
