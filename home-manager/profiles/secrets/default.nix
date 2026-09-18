{config, ...}:
{
  sops = {
    age.keyFile = "/home/azevedo/.config/sops/age/keys.txt";

    defaultSopsFile = ./secrets.yaml;
    secrets = {
        "github_finegrained_token" = {};
    };

    templates."nix-github.conf" = {
        content = ''
            access-tokens = github.com=${config.sops.placeholder."github_finegrained_token"}
        '';
    };
  };
}
