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
            Address="0.0.0.0";
        };
    };
    networking.firewall.allowedTCPPorts = [ port ];
}


