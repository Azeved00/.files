{pkgs, ...}: {


    imports =  [ ];

    dotfiles.home-manager = {
        alacritty.enable = true;
        bash = {
            enable = true;
            repoFolder = "~/Dev/dotfiles";
            hm = "glacion";
            nos = "glacion";
        };
        dunst.enable = true;
        git.enable = true;
        i3= {
            enable = true;
            background-image = ../../assets/Pictures/Backgrounds/fractal.png;
            polybar.modules = {
                wifi.wifi-interface = "wlp5s0";
                bluetooth.enable = true;
                batery = true;
            };
        };
        lf.enable = true;
        nvim.enable = true;
        readline.enable = true;
        rofi.enable = true;
        ssh.enable = true;
        feh.enable = true;
        firefox.enable = true;
        tmux.enable = true;
    };

    home.packages = with pkgs; [ 
        pinta
        spotify
        discord
        parsec-bin
        gnomeExtentions.gestures-improvements
    ];

    bright-bit.user.enable = true;

    xdg = {
        enable = true;

        mimeApps.defaultApplications = {
            "text/plain" = [ "neovim.desktop" ];
            "application/pdf" = [ "zathura.desktop" ];
        };

        userDirs = {
            enable = true;
            createDirectories = false;
        };
    };

    nixpkgs.config.permittedInsecurePackages = [
        "electron-24.8.6"
    ];

}