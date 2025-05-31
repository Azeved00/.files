{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.nvim;
    vimtexPkgs = pkgs.vimPlugins.vimtex;
    vimtexSite  = "${toString vimtexPkgs}/share/vim-plugins/vimtex";
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
                # Force vimtex’s ftplugin to load before the builtin one
                (''
                    if vim.fn.isdirectory('${vimtexSite}') == 1 then
                        vim.opt.runtimepath:prepend('${vimtexSite}')
                    end
                '')
            ]);

            # some default language servers
            extraPackages = with pkgs; [
                rust-analyzer
                texlab
                ccls
                lua-language-server
                nil
            ];

            plugins = with pkgs.vimPlugins; [
                {
                    plugin = nvim-treesitter.withAllGrammars;
                    type = "lua";
                    config = builtins.readFile ./treesitter.lua;
                }
                {
                    plugin = rainbow-delimiters-nvim;
                    type = "lua";
                    config = builtins.readFile ./rainbow.lua;
                }
                {
                    plugin = luasnip;
                    type = "lua";
                    config = (builtins.concatStringsSep "\n" [
                        (builtins.readFile ./luasnip.lua)
                        (''require("luasnip.loaders.from_lua").load({paths = "${./snippets}"})'')

                    ]);
                }
               


                #kanagawa-nvim
                #palenight-vim
                #tokyonight-nvim
                #onehalf

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
                    plugin = render-markdown-nvim;
                    type = "lua";
                    config = builtins.readFile ./markdown.lua;
                }
                {
                    plugin = vimtex;
                    type = "lua";
                    config = builtins.readFile ./vimtex.lua;
                }

           ];
        };
    };
}
