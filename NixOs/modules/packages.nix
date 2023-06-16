{ config, pkgs, ... }:
let
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
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

        bash = {
            # interactiveShellInit = (builtins.readFile ./bash);
        };

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
        
        packageOverrides = pkgs: rec {
            polybar = pkgs.polybar.override {
                i3Support = true;
            };
        };
    };


    environment.systemPackages = with pkgs; [
 	    #basic applications
        wget
        neovim
        networkmanager
        xclip
        git
        pavucontrol
        killall
        tree
        htop
        zip
        unzip

     	#display applications
        rofi
     	i3
	    polybar
	    picom
	    feh
        dunst
        shutter
        playerctl
        
	    # applications
	    alacritty
     	firefox
     	ranger
        jetbrains.idea-ultimate
        zathura
        spotify
        gimp

        # games
        prismlauncher
        steam
        dolphin-emu
        parsec-bin
	    heroic
    ];
}
