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

    home.packages = with pkgs; [wslu ];

    modules.bash.enable = true;

    #targets.genericLinux.enable = true;
    
    xdg = {
        enable = true;
        mime.enable = true;

        desktopEntries = {
            windows = {
                name = "Window";
                genericName = "Windows";
                exec = ''wslview %U""'';
                terminal = false;
                categories = [ ];
                mimeType = [ "text/html" "text/xml" "application/pdf" ];
            };
        };

        mimeApps = {
            enable = true;
            associations.added = {
                "application/pdf" = "windows.desktop";
            };

            defaultApplications = {
                "text/plain" = [ "neovim.desktop" ];
                "application/pdf" = [ "windows.desktop" ];
            };
        };
        
        userDirs = {
            enable = true;
            createDirectories = false;
        };

        systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
    };

}
