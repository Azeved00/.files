{config,lib,...}:
let 
    cfg = config.dotfiles.home-manager.dunst;
in
{
    options.dotfiles.home-manager.dunst = {
        enable = lib.mkEnableOption "Enable dunst Module";
    };

    config = lib.mkIf cfg.enable {
        services.dunst = {
            enable = true;
            configFile = "$HOME/.files/Config/dunst/dunstrc";
        };
    };
}
