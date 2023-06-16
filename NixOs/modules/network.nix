{...}:
{
    networking = {
        hostName = "quininha";

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
}
