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
                ];
            })
            spotify
            discord
        ];
    nixpkgs.config.permittedInsecurePackages = [
        "electron-24.8.6"
    ];
}
