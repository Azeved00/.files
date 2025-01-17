{config, lib, ...}:with lib;
let
    cfg = config.dotfiles.home-manager.zathura;
in
{
    options.dotfiles.home-manager.zathura = {
        enable = mkEnableOption "Enable zathura module";
    };

    config = mkIf cfg.enable {
        programs.zathura = {
            enable = true;
            options = {
                selection-clipboard = "clipboard";
                window-title-basename= true;
            };

        };
    };
}

