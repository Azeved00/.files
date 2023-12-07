{ pkgs, inputs, ...}:
{
    imports = [
        ./apps/alacritty.nix
        ./apps/picom.nix
        ./apps/polybar.nix 
        ./apps/rofi.nix
        ./apps/i3
        ./apps/dunst.nix

        inputs.bright-bit.homeManagerModules.firefox
    ];

    home.packages = with pkgs; [ 
            prismlauncher
	        heroic
            (retroarch.override {
                cores = with libretro; [
                    dolphin
                    citra
                    beetle-gba
                    beetle-psx-hw
                    pcsx2
                ];
            })
            spotify
            discord
            parsec-bin
    ];

    bright-bit.firefox.enable = true;
    

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
