{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.nvim;
in
{
    options.dotfiles.home-manager.nvim= {
        enable = lib.mkEnableOption "Enable nvim module";

        lsps = lib.mkOption {
            description = "Add Extra lsp configurations to neovim.
                These will be appended to lsp.lua file"; 
            default = "";
            type = lib.types.str;
            example = "
            require('lspconfig').ccls.setup {
                 on_attach = on_attach,
                 capabilities = capabilities,
            }";
        };
    };

    config = lib.mkIf cfg.enable {
        programs.neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimAlias = true;

            extraLuaConfig = (builtins.concatStringsSep "\n" [
               (builtins.readFile ./settings.lua)
            ]);

            # some default language servers
            extraPackages = with pkgs; [
                ccls
                lua-language-server
                nil
            ];

            plugins = with pkgs.vimPlugins; [
                rainbow

                kanagawa-nvim
                palenight-vim
                tokyonight-nvim
                onehalf

                nvim-web-devicons
                {
                    plugin = lualine-nvim;
                    type = "lua";
                    config = builtins.readFile ./lualine.lua;
                }
            
                {
                    plugin = nvim-lspconfig;
                    type = "lua";
                    config = (builtins.concatStringsSep "\n" [
                        (builtins.readFile ./lsp.lua)
                        cfg.lsps
                    ]);
                }

                vim-gitgutter
                vim-css-color

                {
                    plugin = (nvim-treesitter.withPlugins (p: [
                        p.tree-sitter-nix
                        p.tree-sitter-c
                        p.tree-sitter-cpp
                        p.tree-sitter-lua
                        p.tree-sitter-vim
                        p.tree-sitter-python
                        p.tree-sitter-bash
                        p.tree-sitter-markdown
                    ]));

                    type = "lua";
                    config = builtins.readFile ./treesitter.lua;
                }
           ];
        };
    };
}
