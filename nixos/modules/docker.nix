{lib, config, ...}:
let
    cfg = config.dotfiles.nixos.docker;
in
with lib;
{
    imports = [];


    options.dotfiles.nixos.docker = {
        enable = mkEnableOption "Enable doker module";
    };

    # udev rule
    config = mkIf cfg.enable {
        virtualisation.docker.enable = true;
        virtualisation.docker.rootless = {
          enable = true;
          setSocketVariable = true;
        };
    };
}
