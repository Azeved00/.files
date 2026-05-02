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
        qutebrowser
        pinta
        inputs.zen-browser.packages.x86_64-linux.default
        stremio
        vlc
        obsidian
    ];
}
