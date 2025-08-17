{...}:
{

    imports = [ ../shared.nix ./hardware.nix ];
    
    networking.hostName = "glaceon";

    dotfiles.nixos.xserver.enable = true;
    dotfiles.nixos.xserver.layout = "pt";
    dotfiles.nixos.tlp.enable = true;
    dotfiles.nixos.bluetooth.enable = true;

    services.xserver.xrandrHeads = [
        {
            output = "eDP-1";
            primary = true;
        }
    ];

}
