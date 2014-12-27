(setq user-full-name "Richard Feldman")
(setq user-mail-address "richard.t.feldman@gmail.com")

(add-to-list 'load-path (expand-file-name "submodules" user-emacs-directory))

(require 'init-packages)


(custom-set-variables
   '(blink-cursor-mode nil)
   '(tool-bar-mode nil)
   '(initial-frame-alist (quote ((fullscreen . maximized))))) ;; start maximized

(provide 'init)
