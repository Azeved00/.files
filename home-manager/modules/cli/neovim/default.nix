{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.nvim;
    vimtexPkgs = pkgs.vimPlugins.vimtex;
    vimtexSite  = "${toString vimtexPkgs}/share/vim-plugins/vimtex";
in
{
    options.dotfiles.home-manager.nvim= {
        enable = lib.mkEnableOption "Enable nvim module";

        lsps = {
            lua = lib.mkOption {
                description = "Enable lua language server and configs"; 
                type = lib.types.bool;
                default = true;
            };
            rust = lib.mkOption {
                description = "Enable rust language server and configs"; 
                type = lib.types.bool;
                default = true;
            };
            go = lib.mkOption {
                description = "Enable go language server and configs"; 
                type = lib.types.bool;
                default = false;
            };
            tex = lib.mkOption {
                description = "Enable tex language server and configs"; 
                type = lib.types.bool;
                default = false;
            };
            c= lib.mkOption {
                description = "Enable C and C++ language server and configs"; 
                type = lib.types.bool;
                default = false;
            };
        };
    };

    config = lib.mkIf cfg.enable {
        xdg.configFile."nvim/after" = {
            recursive = true;
       	    source = ./after;
            enable = true;
        };
        xdg.configFile."nvim/lsp" = {
            recursive = true;
       	    source = ./lsp;
            enable = true;
        };

        programs.neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimAlias = true;

            withPython3 = false;
            withRuby = false;

            initLua = (builtins.concatStringsSep "\n" [
               (builtins.readFile ./settings.lua)
                # Force vimtex’s ftplugin to load before the builtin one
                (''
                    if vim.fn.isdirectory('${vimtexSite}') == 1 then
                        vim.opt.runtimepath:prepend('${vimtexSite}')
                    end
                '')
            ]);

            extraPackages = with pkgs; [
                tree-sitter
                nil
            ] ++ (if cfg.lsps.lua then [pkgs.lua-language-server] else [])
            ++ (if cfg.lsps.c then [pkgs.ccls] else [])
            ++ (if cfg.lsps.rust then [pkgs.rust-analyzer] else [])
            ++ (if cfg.lsps.tex then [pkgs.texlab] else [])
            ++ (if cfg.lsps.go then [pkgs.gopls] else []);

            plugins = with pkgs.vimPlugins; [
                {
                    plugin = nvim-treesitter;
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

                {
                    plugin = nvim-web-devicons;
                    type = "viml";
                }
                {
                    plugin = lualine-nvim;
                    type = "lua";
                    config = builtins.readFile ./lualine.lua;
                }
            
                {
                    plugin = nvim-lspconfig;
                    type = "lua";
                    config = (builtins.concatStringsSep "\n" ([
                        (builtins.readFile ./lsp.lua)
                    ] 
                    ));
                }
                {
                    plugin =vim-gitgutter;
                    type = "viml";
                }
                {
                    plugin =vim-css-color;
                    type = "viml";
                }
                
                {
                    plugin = render-markdown-nvim;
                    type = "lua";
                    config = builtins.readFile ./markdown.lua;
                }
                (lib.mkIf cfg.lsps.tex {
                    plugin = vimtex;
                    type = "viml";
                    config = builtins.readFile ./vimtex.vim;
                })
           ];
        };
    };
}
