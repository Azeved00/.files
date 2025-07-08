set spelllang=en_gb spell
let g:vimtex_fold_enabled = 1

setlocal foldmethod=expr
setlocal foldexpr=vimtex#fold#level(v:lnum)
setlocal foldtext=vimtex#fold#text()
