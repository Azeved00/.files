vim.g.vimtex_compiler_latexmk = {
    executable = 'latexmk',
    out_dir = 'out',
    build_dir = 'build',
    options = {
        '-shell-escape',
        '-xelatex',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_indent_enabled=0


vim.g.tex_conceal = 'abdmg'
vim.o.conceallevel = 2
vim.g.vimtex_syntax_conceal_cites = {
    type= "brackets",
    icon= "📖",
    verbose= "v:true"
}

vim.g.vimtex_toc_enabled=0
vim.g.vimtex_indent_bib_enabled=0
