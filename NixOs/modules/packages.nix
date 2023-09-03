{ pkgs, ... }:
#let
#unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
#in
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

        java = {
            enable = true;
            package = pkgs.jdk8;
        };

    };

    nixpkgs.config = {
        allowUnfree = true;
        pulseaudio = true;
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
        shutter
        playerctl

	    # applications
     	firefox
     	ranger
        zathura

        appimage-run
    ];
}
