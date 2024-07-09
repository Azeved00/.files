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
        drawio
    ];

    bright-bit.user.enable = true;

    xdg = {
        enable = true;
        mimeApps.enable = true;

        mimeApps.defaultApplications = {
            "text/plain" = [ "neovim.desktop" ];
            "application/pdf" = [ "zathura.desktop" ];
            "application/drawio" = [ "drawio.desktop" ];
        };

        userDirs = {
            enable = true;
            createDirectories = false;
        };
        dataFile."mime/packages/drawio.xml"= {
            enable = true;
            onChange = "update-mime-database ~/.local/share/mime";
            text = ''
                <?xml version="1.0" encoding="utf-8"?>
                <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
                <mime-type type="application/vnd.jgraph.mxfile">
                  <glob pattern="*.drawio"/>
                    <comment>draw.io Diagram</comment>
                  <icon name="x-office-document" />
                </mime-type>
                <mime-type type="application/vnd.visio">
                  <glob pattern="*.vsdx"/>
                    <comment>VSDX Document</comment>
                  <icon name="x-office-document" />
                </mime-type>
                </mime-info>
            '';
        };

    };
    nixpkgs.config.permittedInsecurePackages = [
        "electron-24.8.6"
    ];

}
