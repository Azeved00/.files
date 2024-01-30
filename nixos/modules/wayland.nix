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
        services.xserver.displayManager.sddm = {
            enable = true;
            autoNumlock = true;
            wayland.enable = true;
        };


        programs.hyprland.enable = true;
        programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    };

}
