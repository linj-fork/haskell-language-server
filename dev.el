;; -*- lexical-binding: t; -*-

(require 'eglot)
;; enable chooing upstream/hacked HLS
(let ((hls-name "haskell-language-server-wrapper"))
  (let ((major-modes '(haskell-mode haskell-cabal-mode))
        ;; NOTE update this when GHC version or HLS version changes
        (hacked-hls-path "/home/linj/code/fork/haskell-language-server/dist-newstyle/build/x86_64-linux/ghc-9.8.4/haskell-language-server-2.11.0.0/x/haskell-language-server/build/haskell-language-server/haskell-language-server"))
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
