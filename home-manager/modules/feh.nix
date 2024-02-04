{config, lib, ...}:with lib;
let
    cfg = config.dotfiles.home-manager.feh;
in
{
    options.dotfiles.home-manager.feh = {
        enable = mkEnableOption "Enable Feh module";
    };

    config = mkIf cfg.enable {
        programs.feh = {
            enable = true;
            buttons = {};
            keybindings = {
                prev_img = ["h" "Left"];
                next_img = ["l" "Right"];

                zoom_in = ["plus" "k"];  
                zoom_out = ["minus" "j"];

                q = "quit";
            };

        };
    };
}

