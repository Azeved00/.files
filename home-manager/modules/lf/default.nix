{config, lib, ...}:
let 
    cfg = config.dotfiles.home-manager.lf;
in
{

    options.dotfiles.home-manager.lf= {
        enable = lib.mkEnableOption "Enable LF module";
    };

    config = lib.mkIf cfg.enable {
        xdg.configFile."lf/icons".source = ./icons;
        xdg.configFile."lf/colors".source = ./colors;

        programs.lf = {
            enable = true;

            settings = {
                preview = true;
                hidden = true;
                drawbox = true;
                icons = true;
                ignorecase = true;
                # mouse = true;
            };

            commands = {
                edit = ''$$EDITOR $f'';
                mkdir = ''$mkdir $*'';
                touch = ''$touch $*'';
            };

            keybindings = {
                D = "delete"; 
                sf = "push :touch<space>";
                sd = "push :mkdir<space>";
            };
        };
    };
}
