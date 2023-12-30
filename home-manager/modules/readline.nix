{ config, pkgs, lib, ...}:
{
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

}
