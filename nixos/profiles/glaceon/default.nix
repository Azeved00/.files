{...}:
{

    imports = [ ../shared.nix ./hardware.nix ];
    
    dotfiles.nixos.network.name = "glaceon";

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

    services.zerotierone.enable = false;

    virtualisation.docker = {
        enable = false;
        rootless = {
            enable = true;
            setSocketVariable = true;
        };
    };
}
