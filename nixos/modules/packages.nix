{ pkgs, inputs, ... }:
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
 	    #basic applications
        gcc
        wget
        networkmanager
        xclip
        git
        pavucontrol
        killall
        tree
        htop
        zip
        unzip
        home-manager

     	#display applications
     	i3
	    feh
        dunst
        gnome.gnome-screenshot
        playerctl

	    # applications
     	firefox
        zathura
        lf
    ];
}
