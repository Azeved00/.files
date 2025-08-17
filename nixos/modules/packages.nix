{ pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
 	    #command line stuyff
        gcc
        wget
        networkmanager
        git
        home-manager
        neovim
        appimage-run
        steam-run

     	#other apps
     	i3
        networkmanagerapplet
        pavucontrol
        zathura
        lf
        alacritty
    ];

    #programs.firefox.enable = lib.mkDefault true;
}
