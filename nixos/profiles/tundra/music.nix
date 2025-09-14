{...}:
let
    port = 4533;
in
{   
    services.navidrome = {
        enable = true;
        environmentFile = null;

        group = "navidrome";
        user = "navidrome";

        settings = {
            Port = port;
        };
    };
    networking.firewall.allowedTCPPorts = [ port ];
}


