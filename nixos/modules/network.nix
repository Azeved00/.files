{lib, config, ...}:
let
    cfg = config.dotfiles.nixos.network;
in
with lib;
{

    options.dotfiles.nixos.network = {
        name = mkOption {
            default = "quininha";
            type = types.str;
            description = "Computers HostName";
        };
    };

    config = {
        networking = {
            hostName = cfg.name;

            proxy = {
                # networking.proxy.default = "http://user:password@proxy:port/";
                # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
            };
        
            networkmanager.enable = true;
            networkmanager.wifi.scanRandMacAddress = false;

            firewall.enable = true;
            firewall.allowedTCPPorts = [ ];
            firewall.allowedUDPPorts = [ ];
        };
    };
}
