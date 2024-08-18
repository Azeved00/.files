{config,lib,...}:
let 
    cfg = config.dotfiles.home-manager.desktop.gtk;
in
{
    options.dotfiles.home-manager.desktop.gtk = {
        enable = lib.mkEnableOption "Enable the gtk theme";
    };

    config = lib.mkIf cfg.enable {
        gtk = {
            enable = true;
            theme = {
                name = "Adwaita-dark";
            };

        };
    };
}
