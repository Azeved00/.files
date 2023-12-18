{pkgs, config, ...}:
{
    imports = [
        ./apps
        ./apps/git.nix
        ./apps/readline.nix
        ./apps/neovim/program.nix 
        ./apps/ssh.nix
        ./apps/lf/program.nix
    ];

    home.packages = with pkgs; [
        wslu
        shared-mime-info
    ];

    modules.bash.enable = true;
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
