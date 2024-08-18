{config, lib, ...}:with lib;
let
    cfg = config.dotfiles.home-manager.desktop.i3.redshift;
in
{
    options.dotfiles.home-manager.desktop.i3.redshift = {
        enable = mkEnableOption "Enable Redshift module";
    };

    config = mkIf cfg.enable {
        services.redshift = {
            enable = true;
            dawnTime = "07:00";
            duskTime = "20:00";
            temperature.day = 6500;
            temperature.night = 4000;
        };
    };
}

