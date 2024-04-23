{config, lib, ...}:with lib;
let
    cfg = config.dotfiles.home-manager.tmux;
in
{
    options.dotfiles.home-manager.tmux = {
        enable = mkEnableOption "Enable Tmux module";
    };

    config = mkIf cfg.enable {
        programs.tmux = {
            enable = true;
            
            clock24 = true;
            disableConfirmationPrompt = true;
            mouse = true;
            keyMode = "vi";
            customPaneNavigationAndResize = true;

            extraConfig = (builtins.concatStringsSep "\n" [
               (builtins.readFile ./config)
            ]);
        };
    };
}

