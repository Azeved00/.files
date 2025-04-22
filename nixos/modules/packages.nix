{ pkgs, lib, ... }:
{
    programs = {
        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        # mtr.enable = true;
        # gnupg.agent = {
        #   enable = true;
        #   enableSSHSupport = true;
        # };

        ssh = {
            startAgent = true;
        };
    };

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
