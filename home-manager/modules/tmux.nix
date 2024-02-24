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
            #shortcut = "w";
            keyMode = "vi";
            customPaneNavigationAndResize = true;

            extraConfig = "
                unbind C-b
                set-option -g prefix C-w
                bind-key C-w send-prefix

                set-option -g status-position top
                set -s escape-time 50 
            "; 

        };
    };
}

