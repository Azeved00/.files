{config,lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.eww;
    eww = pkgs.eww;
in
with lib;
{
    options.dotfiles.home-manager.eww = {
        enable = mkEnableOption "Enable Eww module";
    };

    config = mkIf cfg.enable {
        xdg.configFile."launch_eww_bar" = {
            enable = true;
            executable = true;
            target = "launch_eww_bar.sh";
            text = ''
                ## Files and cmd
                FILE="$HOME/.cache/eww_launch.xyz"
                EWW="${eww}/bin/eww -c $HOME/.config/eww/bar"

                ## Run eww daemon if not running already
                if [[ ! `pidof eww` ]]; then
                    ''${EWW} daemon
                    sleep 1
                fi

                ## Open widgets 
                run_eww() {
                    ''${EWW} open-many \
                         bar
                        
                }

                ## Launch or close widgets accordingly
                if [[ ! -f "$FILE" ]]; then
                    touch "$FILE"
                    run_eww && bspc config -m LVDS-1 top_padding 49
                else
                   ''${EWW} close-all && killall eww
                    rm "$FILE"
                fi

            '';
        };



        programs.eww = {
            enable = true;
            configDir = ./.;
            package = eww;
        };

    };
}
