{ config, lib,...}:
with lib;
let
  cfg = config.dotfiles.home-manager.bash;
in
{
    imports = [];
    
    options.dotfiles.home-manager.bash = {
        enable = mkEnableOption "bash module";
        repoFolder = mkOption {
            description = ".files folder";
            default = "~/.files";
            type = types.str;
        };
        hm = mkOption {
            description = "home-manager profile name";
            default = "azevedo";
            type = types.str;
        };
        nos = mkOption {
            description = "nixos profile name";
            default = "home-pc";
            type = types.str;
        };
    };

    config = mkIf cfg.enable {
        programs.bash = {
            enable = true;

            shellAliases = {
                "reload"="source ${config.home.homeDirectory}/.bashrc";

                "mysql"="mysql -u root -p";
            
                "ls" = "ls --colo=auto";
                "ll" = "ls -l";
                "la" = "ls -la";

                ".." = "cd ..";
                "..." = "cd ../../";

                "g" = "git";
                
                "dotfiles"=''pushd ${cfg.repoFolder}; tmux new-session -t dotfiles; popd;'';
                "hm"="home-manager --flake ${cfg.repoFolder}#${cfg.hm}";
                "nosr" = "sudo nixos-rebuild --flake ${cfg.repoFolder}#${cfg.nos}";
                "new-dev" = "nix flake new -t ${cfg.repoFolder}#dev";
            };

            profileExtra = "";
            
            initExtra = builtins.readFile ./prompt.sh;

            bashrcExtra = builtins.readFile ./funcs.sh;

            shellOptions = [
                "histappend"    # append to history file, dont overwrite it
                "checkwinsize"  # checkwindow size after each command
                "nocaseglob"    # case insensitive globbing
                "cdspell"       # autocorrect typos in path names in cd
            ];

            sessionVariables = {
                CLICOLOR = "1";
                LSCOLORS = "gxfxcxdxbxegedabagacad";

                GREP_OPTIONS = "-color=auto";
                HISTCONTROL="ignoreboth";
                TERMINAL = "alacritty";
                PROMPT_COMMAND="make_prompt";
                PS2=" 󱞩 ";
            }; 

            historySize = 2000;
            historyFileSize = 10000;
        };
    };
}
