{lib, config, ...}:
let
    cfg = config.dotfiles.nixos.network;
in
with lib;
{

    options.dotfiles.nixos.network = {
    };

    config = {
        networking = {
            proxy = {
                # networking.proxy.default = "http://user:password@proxy:port/";
                # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
            };
        
            wireless.enable = lib.mkForce false;
            networkmanager.enable = true;
            networkmanager.wifi.scanRandMacAddress = false;

            firewall.enable = true;
        };
    };
}
