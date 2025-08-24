{ pkgs, inputs, ... }:
{
    imports = [
        inputs.sops-nix.nixosModules.sops
    ];

    sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";

        age.keyFile = "/home/azevedo/.config/sops/age/keys.txt";
        
        secrets.my_domain = {};
        secrets."cloudflared/grafana-tunnel/tunnel-credentials" = {};
    };
}

