{lib, config, ...}:
{

    imports = [ 
        ./hardware.nix ./users.nix

        ./plantinhas.nix
        ./data.nix
        #./retroserver.nix
        ./obsidian.nix
        ./music.nix
    ];
     
    dotfiles.nixos.xserver.enable = false;
    dotfiles.nixos.ssh.enable = true;
    dotfiles.nixos.docker.enable = true;
    dotfiles.nixos.gui = false;
    sops.age.keyFile = lib.mkForce "/root/.config/sops/age/keys.txt";

    services ={
        openssh.settings = {
            PermitRootLogin = lib.mkForce "yes"; 
        };

        cloudflared = {
            enable = true;
            tunnels = {
              "Grafana" = {
                credentialsFile = config.sops.secrets."cloudflared/grafana-tunnel/tunnel-credentials".path;
                default = "http_status:404";
              };
            };
        };
    };

    networking.hostName = "tundra";
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [22];
        trustedInterfaces = [ "tailscale0" ];
    };

    system.autoUpgrade.enable = true;

}

