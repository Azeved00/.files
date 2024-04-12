{config, lib, ...}:with lib;
let
    cfg = config.dotfiles.home-manager.eww;
in
{
    options.dotfiles.home-manager.eww = {
        enable = mkEnableOption "Enable eww bar module";
    };

    config = mkIf cfg.enable {
        programs.eww = {
            enable = true;
            configDir = ./.;
        };
        
    };
}

