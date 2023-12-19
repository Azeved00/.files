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
    
    xdg = {
        enable = true;
        mime.enable = true;

        desktopEntries = {};

        mimeApps = {
            enable = true;
        };
        
        userDirs = {
            enable = true;
            createDirectories = false;
        };

        systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
    };

}
