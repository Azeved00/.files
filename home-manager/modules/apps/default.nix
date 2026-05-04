{pkgs, inputs, ...}:
{
    imports =  [
        ./alacritty.nix
        ./feh.nix
        ./firefox.nix
        ./zathura.nix
        ./drawio.nix
    ];

    home.packages = with pkgs; [ 
        pinta
        vlc
        obsidian
    ];
}
