{ pkgs, ...}:
{
    imports = [
        ./apps/alacritty.nix
        ./apps/picom.nix
        ./apps/polybar.nix 
        ./apps/rofi.nix
        ./apps/i3/program.nix
        ./apps/dunst.nix
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
    ];

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
