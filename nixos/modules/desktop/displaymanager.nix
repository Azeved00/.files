{ lib, config,inputs,pkgs, ...}:
let
    cfg = config.dotfiles.nixos.dm;
in
with lib;
{
    imports = [];

    options.dotfiles.nixos.dm= {
        enable = mkEnableOption "enable display manager";
    };

    config = mkIf cfg.enable {
        services.displayManager = {
            sddm = {
                enable = false;
                autoNumlock = true;
            };
            ly.enable= true;
        };           
    };
}
