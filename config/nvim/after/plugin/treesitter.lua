vim.opt.runtimepath:append("$XDG_DATA_HOME/nvim/treesitter")

require'nvim-treesitter.configs'.setup {
    parser_install_dir = "$XDG_DATA_HOME/nvim/treesitter",
    ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "nix" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })
