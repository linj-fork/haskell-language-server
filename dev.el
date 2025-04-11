;; -*- lexical-binding: t; -*-

(require 'eglot)
;; enable chooing upstream/hacked HLS
(let ((hls-name "haskell-language-server-wrapper"))
  (let ((major-modes '(haskell-mode haskell-cabal-mode))
        (hacked-hls-path "/home/linj/code/fork/haskell-language-server/dist-newstyle/build/x86_64-linux/ghc-9.8.4/haskell-language-server-2.10.0.0/x/haskell-language-server/build/haskell-language-server/haskell-language-server"))
    (setf (alist-get major-modes
                     eglot-server-programs
                     nil nil
                     #'equal)
          (eglot-alternatives (mapcar (lambda (hls) (list hls "lsp"))
                                      (list hls-name hacked-hls-path)))))
  t)

(keymap-global-set "<f5>" #'tab-next)
(keymap-global-set "<f6>" #'eglot)
(keymap-global-set "S-<f6>" #'eglot-shutdown)

(when (string= (system-name) "spe")
  (setopt browse-url-browser-function #'eww-browse-url))

;; build HLS (config at .dir-locals.el)
;; (let ((wd (expand-file-name "~/code/fork/haskell-language-server/")))
;;   (linj-misc-run-async-command-then-notify
;;    `("direnv" "exec" ,wd "cabal" "build" "exe:haskell-language-server")
;;    :working-directory wd))
