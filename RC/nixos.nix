# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
    [ 
        /etc/nixos/hardware-configuration.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.device = "nodev";
    boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];


    # Set your time zone.
    time.timeZone = "Europe/London";


    networking = {
        hostName = "quininha";

        proxy = {
            # networking.proxy.default = "http://user:password@proxy:port/";
            # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
        };
    
        networkmanager.enable = true;

        firewall.enable = true;
        firewall.allowedTCPPorts = [ ];
        firewall.allowedUDPPorts = [ ];
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "jetbrains-mono";
        # keyMap = "pt";
        useXkbConfig = true; # use xkbOptions in tty.
    };

    # Configure keymap in X11
    services.xserver = {
        enable = true;
        autorun = true;
        layout = "pt";
        desktopManager.xterm.enable = false;
        
        displayManager = {
            lightdm.enable = true;
            defaultSession = "none+i3";
        };
        
        windowManager = {
	        i3.enable = true;
	        i3.package = pkgs.i3-gaps;
        };

        libinput.enable = true;

        # xserver.xkbOptions = {
        #   "eurosign:e";
        #   "caps:escape" # map caps to escape.
        # };
    };
  
    

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    sound.enable = true;
    nixpkgs.config.pulseaudio = true;
    hardware.pulseaudio.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.azevedo = {
        initialPassword = "pw123";
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" ];
    };

    nixpkgs.config.allowUnfree = true;
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    # List packages installed in system profile. To search, run:
    environment.systemPackages = with pkgs; [
 	    # basic applications
     	wget
     	neovim
     	networkmanager
     	clipmenu
	    git
	    pavucontrol
     
     	#display applications
     	rofi
     	i3
	    polybar
	    picom
	    feh
     
	    # applications
	    alacritty
     	firefox
     	ranger
	    heroic
        steam
        jetbrains.idea-ultimate

        # others
        jetbrains-mono
        jdk8
    ];
    environment.sessionVariables = {  
        TERMINAL = "alacritty";
        EDITOR = "nvim";
    };

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };
    


    system.stateVersion = "22.11"; 
}

