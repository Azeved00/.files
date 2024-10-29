{config, lib, ...}:with lib;
let
    cfg = config.dotfiles.home-manager.desktop.eww;
in
{
    options.dotfiles.home-manager.desktop.eww = {
        enable = mkEnableOption "Enable eww bar module";
    };

    config = mkIf cfg.enable {
        programs.eww = {
            enable = true;
            configDir = ./.;
        };
        
    };
}
