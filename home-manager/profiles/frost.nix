{pkgs, config, ...}:
{
    imports = [
        ./apps
        ./apps/git.nix
        ./apps/readline.nix
        ./apps/neovim 
        ./apps/ssh.nix
        ./apps/lf
    ];

    home.packages = with pkgs; [
        wslu
        shared-mime-info
    ];

    modules.bash = {
        enable = true;
        repoFolder = "~/.files";
        hm = "wsl";
    };

    programs.bash.sessionVariables = {
        BROWSER = "wslview";
    };
    #targets.genericLinux.enable = true;

}
