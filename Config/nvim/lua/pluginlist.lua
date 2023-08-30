-- 'folke/tokyonight.nvim'
-- 'rebelot/kanagawa.nvim'
-- 'drewtempelmeyer/palenight.vim'


return {
    "airblade/vim-gitgutter",
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme kanagawa-wave")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("lualine").setup({
                icons_enable = true,
                theme = 'gruvbox',
            })
        end,
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}
