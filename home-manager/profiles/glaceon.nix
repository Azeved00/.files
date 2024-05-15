{pkgs, ...}: {


    imports =  [ ];

    dotfiles.home-manager = {
        alacritty.enable = true;
        dunst.enable = true;
        i3= {
            enable = true;
            background-image = ../../assets/Pictures/Backgrounds/ball.png;
            polybar= {
                enable = false;
                modules = {
                    wifi.wifi-interface = "wlp5s0";
                    bluetooth.enable = false;
                    battery = {
                        enable = true;
                        battery = "BAT0";
                        adapter = "AC";
                    };
                    temperature.file = "";
                };
            };
            monitor-config = ''
                workspace 1 output eDP-1
            '';
        };
        eww.enable=true;
        nvim.enable = true;
        rofi.enable = true;
        feh.enable = true;
        firefox.enable = true;
        zathura.enable = true;

        fastfetch.enable = true;
        lf.enable = true;
        tmux.enable = true;
        terminal.packages.enable = true;
        git.enable = true;
        readline.enable = true;
        ssh.enable = true;
        bash = {
            enable = true;
            repoFolder = "~/Dev/dotfiles";
            hm = "glaceon";
            nos = "glaceon";
        };
    };

    home.packages = with pkgs; [ 
        pinta
        spotify
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
