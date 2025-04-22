{pkgs, ...}:
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


    services.postgresql.enable = true;
    services.zerotierone.enable = true;

    services.matrix-synapse = { 
        enable = true;
        settings.server_name = "fcup";
        settings.args.database = {
            database = "synapse";
            user = "synapse";
            host = "localhost";
            password = "mysupersecret";
        };
        settings.listeners = [
          {
            bind_addresses = [ "127.0.0.1" ];
            port = 8008;
            resources = [
                {
                    compress = true;
                    names = [
                      "client"
                    ];
                }
                {
                    compress = false;
                    names = [
                      "federation"
                    ];
                }
            ];
            tls = false;
            type = "http";
            x_forwarded = true;
          }
        ];
    };

}
