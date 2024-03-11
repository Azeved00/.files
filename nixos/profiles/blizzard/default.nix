{...}:
{

    imports = [ ./hardware.nix ];
    
    dotfiles.nixos.network.name = "blizzard";

    dotfiles.nixos.xserver.enable = true;
    dotfiles.nixos.xserver.layout = "us";

    dotfiles.nixos.wayland.enable = true;

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
            monitorConfig = ''
                DisplaySize 1920 1080
            '';
        }
        {
            output = "DP-3";
            monitorConfig = ''
                DisplaySize 1920 1080
                Option "RightOf" "HDMI-1"

            '';
        }
    ];
}
