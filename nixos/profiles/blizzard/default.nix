{lib, ...}:
{

    imports = [ ../shared.nix ./hardware.nix ];

    dotfiles.nixos.network.name = "blizzard";
    dotfiles.nixos.xserver.layout = "us";
    bright-bit.system.sddm.theme-config = ''
                [General]
                clockEnabled="true"
                clockSize=40
    '';
    services.xserver.xrandrHeads = [
        {
            output = "HDMI-1";
            primary = true;
            #   DisplaySize 1920 1080
            monitorConfig = ''
            '';
        }
        {
            output = "DP-3";
            #   DisplaySize 1920 1080
            monitorConfig = ''
                Option "RightOf" "HDMI-1"
            '';
        }
    ];

    dotfiles.nixos.xserver.enable = true;
    dotfiles.nixos.wayland.enable = false;
    dotfiles.nixos.docker.enable =true;


            programs.steam = {
                enable = true;
                # Open ports in the firewall for Steam Remote Play
                remotePlay.openFirewall = true;
                # Open ports in the firewall for Source Dedicated Server
                dedicatedServer.openFirewall = true; 
            };
    
    specialisation = {
        gaming.configuration = {
            system.nixos.tags = [ "Gaming" ];
            programs.gamemode.enable = true;

        };
        
        server.configuration = {
            system.nixos.tags = [ "Headless" ];

            dotfiles.nixos.xserver.enable = lib.mkForce false;
            dotfiles.nixos.wayland.enable = lib.mkForce false;
            services.zerotierone.enable = true;

            #networking.firewall.allowedTCPPorts = [22];
        };
    };
}
