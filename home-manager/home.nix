{config, pkgs, lib, ...}:
{
    imports = [
        ./git.nix
        ./bash.nix
        ./readline.nix
        ./ssh.nix

        ./alacritty.nix
        ./picom.nix
        ./neovim.nix
        ./polybar.nix
    ];

    home.username = "azevedo";
    home.homeDirectory = "/home/azevedo";
    home.stateVersion = "23.05";
    home.packages = [ ];

    home.file = {};
        
    xdg.mimeApps.defaultApplications = {
        "text/plain" = [ "neovim.desktop" ];
        "application/pdf" = [ "zathura.desktop" ];
    };

    programs.home-manager.enable = true;
}
