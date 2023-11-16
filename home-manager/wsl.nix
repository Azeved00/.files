{config, ...}:
{
    imports = [];

    home.packages = [ ];

    #targets.genericLinux.enable = true;
    
    xdg = {
        enable = true;
        mime.enable = true;

        desktopEntries = {
            firefox = {
                name = "Firefox.exe";
                genericName = "Web Browser";
                exec = ''/mnt/c/Program\ Files/Firefox\ Developer\ Edition/firefox.exe "\$(wslpath -w \"\$(readlink -f %U)\")"'';
                terminal = false;
                categories = [ "Network" "WebBrowser" ];
                mimeType = [ "text/html" "text/xml" "application/pdf" ];
            };
        };

        mimeApps = {
            enable = true;
            
            associations.added = {
                "application/pdf" = "firefox.desktop";
            };

            defaultApplications = {
                "text/plain" = [ "neovim.desktop" ];
                "application/pdf" = [ "firefox.desktop" ];
            };
        };
        
        userDirs = {
            enable = true;
            createDirectories = false;
        };

        systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
    };


}
