-- 'folke/tokyonight.nvim'
-- 'rebelot/kanagawa.nvim'
-- 'drewtempelmeyer/palenight.vim'


return {
    "airblade/vim-gitgutter",
    "HiPhish/nvim-ts-rainbow2",
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
    {
        "nvim-treesitter/nvim-treesitter",
        config = function ()
            vim.opt.runtimepath:append("$XDG_DATA_HOME/nvim/treesitter")
            require'nvim-treesitter.configs'.setup {
                parser_install_dir = "$XDG_DATA_HOME/nvim/treesitter",
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "nix" },

                highlight = {
                    enable = true,
                },
                rainbow = {
                    enable = true,
                    query = 'rainbow-parens',
                    strategy = require('ts-rainbow').strategy.global,
                },
            }
        end
    },
    "neovim/nvim-lspconfig",
}
