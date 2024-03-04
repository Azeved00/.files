{ config, lib, ...}:
let 
    cfg = config.dotfiles.home-manager.readline;
in
{

    options.dotfiles.home-manager.readline = {
        enable = lib.mkEnableOption "Enable readline module";
    };

    config = lib.mkIf cfg.enable {
        programs.readline = {
            enable = true;
            bindings = {
                "\\e[Z" = "menu-complete";
                "\\e[A" = "history-search-backward";
                "\\e[B" = "history-search-forward";
            };
            variables = {
                completion-ignore-case = true;
                show-all-if-ambiguous = true;
            };
        };
    };

}
