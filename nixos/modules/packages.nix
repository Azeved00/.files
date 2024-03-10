{ pkgs, ... }:
{
    programs = {
        steam = {
            enable = true;
        
            # Open ports in the firewall for Steam Remote Play
            remotePlay.openFirewall = true;
        
            # Open ports in the firewall for Source Dedicated Server
            dedicatedServer.openFirewall = true; 
        };
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

     	#other apps
     	i3
        networkmanagerapplet
        pavucontrol
     	firefox
        zathura
        lf
        alacritty
    ];
}
