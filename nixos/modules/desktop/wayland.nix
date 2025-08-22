{ lib, config,inputs,pkgs, ...}:
let
    cfg = config.dotfiles.nixos.wayland;
in
with lib;
{
    imports = [];

    options.dotfiles.nixos.wayland = {
        enable = mkEnableOption "enable wayland";
    };

    config = mkIf cfg.enable {
        dotfiles.nixos.dm.enable = true;

        services.displayManager.sddm = {
            wayland.enable = true;
        };

        environment.sessionVariables = {
            NIXOS_OZONE_WL = "1";
        };


        programs.hyprland = {
            enable = true;
            xwayland.enable = true;
            package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        };

    };

}
