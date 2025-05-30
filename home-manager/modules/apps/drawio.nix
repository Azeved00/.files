{config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.drawio;
in
{
    options.dotfiles.home-manager.drawio = {
        enable = lib.mkEnableOption "Enable Drawio Module";
    };

    config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ drawio ];
    };
}


