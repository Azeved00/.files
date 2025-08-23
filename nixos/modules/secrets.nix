{ pkgs, inputs, ... }:
{
    imports = [
        inputs.sops-nix.nixosModules.sops
    ];

    sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        defaultSopsFormat = "yaml";

        age.keyFile = "/home/azevedo/.config/sops/age/keys.txt";
        
        secrets.example-key = {};
        secrets."myservice/my_subdir/my_secret" = {};
        secrets."cloudflared/grafana-tunnel/tunnel-credentials" = {};
    };
}

