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
}
