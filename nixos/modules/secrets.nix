{ pkgs, inputs, ... }:
{
    imports = [
        inputs.sops-nix.nixosModules.sops
    ];

    sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";

        age.keyFile = "/home/azevedo/.config/sops/age/keys.txt";
        
        secrets."grafana/env" = {};
        secrets."retro-webdav" = {};
        secrets."cloudflared/grafana-tunnel/tunnel-credentials" = {
            mode = "0440";
            owner = "grafana";
            group = "grafana";
        };
    };
}

