vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.encoding = 'UTF-8'

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.smarttab = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.autoindent = true
vim.o.expandtab = true

vim.o.foldmethod = 'indent'
vim.o.nofoldenable = true
vim.o.foldlevel = 99

vim.o.updatetime = 300
vim.o.termguicolors = true

vim.o.mouse = 'a'

 vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>",  {noremap = true, silent = true} )
