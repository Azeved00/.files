{...}:
{

    imports = [ ../shared.nix ./hardware.nix ];
    
    dotfiles.nixos.network.name = "blizzard";

    dotfiles.nixos.xserver.enable = true;
    dotfiles.nixos.xserver.layout = "us";

    dotfiles.nixos.wayland.enable = true;

    bright-bit.system.sddm.theme-config = ''
                [General]
                clockEnabled="true"
                clockSize=40
    '';

    programs.steam = {
        enable = true;
        # Open ports in the firewall for Steam Remote Play
        remotePlay.openFirewall = true;
        # Open ports in the firewall for Source Dedicated Server
        dedicatedServer.openFirewall = true; 
    };

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
}
